import Types "types";
import { now } "mo:base/Time";
import Array "mo:base/Array";
import List "mo:base/List";
import Map "mo:map/Map";
import { phash; nhash; thash } "mo:map/Map";
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import Nat64 "mo:base/Nat64";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import LedgerTypes "../interfaces/ICP_Token/ledger_icp";
import { print } "mo:base/Debug";
import Utils "../backend/utils";


shared ({caller = superAdmin}) persistent actor class Treasury(initArgs: Types.InitArgs) = this {

    /////////////////////////////////////////// Types ////////////////////////////////////////////////////////

    type Account = Types.Account;
    type ActivityLogEntry = Types.ActivityLogEntry;
    type WhitdrawalLogEntry = Types.WhitdrawalLogEntry;

    /////////////////////////////////////// Variables state /////////////////////////////////////////////////

    var admins: [Principal] = [superAdmin];
    var activityLog: List.List<ActivityLogEntry> = List.nil<ActivityLogEntry>();
    var _withdrawalLog: List.List<WhitdrawalLogEntry> = List.nil<Types.WhitdrawalLogEntry>();
    var _internalSubaccounts: [Blob] = [
        "feecollector00000000000000000000",
        "escrows0000000000000000000000000",
    ];
    let escrows = Map.new<Types.EscrowId, Types.Escrow>();

    let supportedTokens = Map.make<Text, Types.Token>(thash, "Internet Computer", Types.icpToken());

    var lastEscrowId = 0;
    var lastMemoTransactionId = 0;

    var withdrawableBalances = Map.new<Principal, [Types.Balance]>();

    //////////////////////////////////// Private Functions ///////////////////////////////////////////////////

    func isAdmin(caller: Principal): Bool {
        for(a in admins.vals()) if(a == caller ) return true ;
        return false;
    };

    func getAccountByUser(u: Principal) : Account {
        { owner = Principal.fromActor(this); subaccount = ? Principal.toLedgerAccount(u, null)}
    };

    func remoteLedger(p: Principal): actor {
        icrc1_balance_of : shared query Account -> async Nat;
        icrc1_transfer : shared LedgerTypes.TransferArg -> async LedgerTypes.Result;
        query_blocks : shared query LedgerTypes.GetBlocksArgs -> async LedgerTypes.QueryBlocksResponse;
        icrc1_fee : shared query () -> async Nat;
    } {
        actor(Principal.toText(p))
    };

    func newMemo() : Blob {
        lastMemoTransactionId += 1;
        let txnText = Nat.toText(lastMemoTransactionId % 1000000000);
        Text.encodeUtf8("ITP_WithdrawalTRX:" # txnText)
    };

    //////////////////////////////////// Admin Functions ////////////////////////////////////////////////////


    public shared ({ caller }) func addAdmin(a: Principal): async Bool{
        assert isAdmin(caller);
        if(not isAdmin(a)) {
            admins := Array.tabulate<Principal>(
                admins.size() + 1,
                func i = if (i < admins.size()) admins[i] else a
            );
            let newLogEntry:  Types.ActivityLogEntry = {
                timestamp = now();
                caller = caller;
                action = #AddAdmin(a)
            };
            activityLog := List.push<Types.ActivityLogEntry>( newLogEntry, activityLog);
            return true;
        };
        return false;
    };

    public shared ({ caller }) func removeAdmin(a: Principal): async Bool{
        assert isAdmin(caller) and a != superAdmin;
        for( admin in admins.vals()){
            if (admin == a) {
                admins := Array.filter<Principal>(admins, func x = x != a);
                let newLogEntry: Types.ActivityLogEntry = {
                    timestamp = now();
                    caller = caller;
                    action = #RemoveAdmin(a)
                };
                activityLog := List.push<Types.ActivityLogEntry>(newLogEntry, activityLog);
                return true;
            };
        };
        return false;
    };

    public shared ({ caller }) func addToken(canisterId: Principal): async Bool {
        assert isAdmin(caller);
        let tokenLedger = actor(Principal.toText(canisterId)): actor {
            icrc1_metadata : shared query () -> async [(Text, Types.MetadataValue)];
        };
        let metadata = await tokenLedger.icrc1_metadata();
        var name = "";
        var logo = "";
        var symbol = "";
        var decimals = 0;
        var fee = 0;
    
        for (field in metadata.vals()) {
           switch (field) {
            case ("icrc1:name", #Text(_name)) { name := name };
            case ("icrc1:symbol", #Text(_symbol)) { symbol := symbol };
            case ("icrc1:logo", #Text(_logo)) {logo := _logo};
            case ("icrc1:fee", #Nat(_fee)) { fee := _fee };
            case ("icrc1:decimals", #Nat(_decimals)) { decimals := _decimals };
            case _ {}
           }
        };
        if (name == "" or symbol == "" or decimals == 0 or fee != 0) {
            return false
        };
        let newToken: Types.Token = {
            name;
            symbol;
            logo;
            fee;
            decimals;
            canisterId;
        };            
        ignore Map.put<Text, Types.Token>(supportedTokens, thash, name, newToken);
        true 
    };

    public shared query ({ caller }) func balancesOf(p: Principal): async ?[Types.Balance] {
        assert isAdmin(caller);
        Map.get<Principal, [Types.Balance]>(withdrawableBalances, phash, p)
    };

    public shared query ({ caller }) func getDepositAccount(u: Principal): async Account{
        assert isAdmin(caller);
        getAccountByUser(u)
    };

    //////////////////////////////////// Public Functions ///////////////////////////////////////////////////

    public query func getAdmins(): async [Principal]{
        admins
    };

    public query func getSupportedTokens(): async [Types.Token] {
        Iter.toArray<Types.Token>(Map.vals<Text, Types.Token>(supportedTokens))
    };

    public shared query ({ caller }) func getMyDepositAccount(): async Account {
        assert (not Principal.isAnonymous(caller));
        getAccountByUser(caller)
    };

    func verifyTransaction(args: LedgerTypes.TransferArg, blocks: [LedgerTypes.CandidBlock]): Bool {
        for ({ transaction } in blocks.vals()){
            switch (transaction.operation){
                case (? #Transfer(t)) {
                    let toVerified = t.to == Principal.toLedgerAccount(args.to.owner, args.to.subaccount);
                    let amountVerified = t.amount == {e8s = Nat64.fromNat(args.amount)};
                    let window = 60000000000: Nat64; 
                    let signature_delay = switch (args.created_at_time){
                        case null 0: Nat64;
                        case (?_created_at_time) {
                           transaction.created_at_time.timestamp_nanos - _created_at_time
                        }
                    };
                    // let created_at_time_verified = ?transaction.created_at_time.timestamp_nanos == args.created_at_time;
                    let created_at_time_verified = window >= signature_delay;
                    print(debug_show(toVerified));
                    print(debug_show(amountVerified));
                    print(debug_show(created_at_time_verified));

                    print(debug_show({transaction= transaction.created_at_time.timestamp_nanos}));
                    print(debug_show({args = args.created_at_time}));
                    if (toVerified and amountVerified and created_at_time_verified){
                        return true
                    };       
                };
                case _ {};
            }
        };
        false
    };
    
    public shared ({ caller }) func createEscrow(args: Types.CreateEscrowArgs): async {#Ok: Types.EscrowId; #Err: Text }{
        if(caller != initArgs.mainPlatform){
            return #Err("Only the main platform can create escrows");
        };
        let ledger = remoteLedger(args.token);
        let { blocks } = await ledger.query_blocks({ start = args.index; length = args.index});
        var transactionVerified = verifyTransaction(args.transferArg, blocks);
        if (not transactionVerified) {
            return #Err("Transaction verification failed");
        };
        lastEscrowId += 1;
        let newEscrow: Types.Escrow = {
            amount = args.transferArg.amount;
            platformFee = args.platformFee;
            fromSubaccount = "escrows0000000000000000000000000";
            id = lastEscrowId;
            userAssigned = args.userAssigned;
            token = args.token;
        };
        ignore Map.put<Types.EscrowId, Types.Escrow>(escrows, nhash, lastEscrowId, newEscrow);
        #Ok(newEscrow.id)
    };

    public shared ({ caller }) func releaseEscrow(id: Types.EscrowId): async Bool {
        if(caller != initArgs.mainPlatform) return false ;
        let escrow = Map.remove<Types.EscrowId, Types.Escrow>(escrows, nhash, id);
        switch (escrow) {
            case null { return false };
            case ( ?escrow ) {
                let currentUserBalances = switch (Map.get<Principal, [Types.Balance]>(withdrawableBalances, phash, escrow.userAssigned)) {
                    case null { [] };
                    case ( ?balances ) { balances }
                };
                let bufferBalances = Buffer.Buffer<Types.Balance>(0);
                var currentBalanceOfTokenUsed = 0;
                for (currentBal in currentUserBalances.vals() ) {
                    if (currentBal.token != escrow.token) {
                        bufferBalances.add(currentBal);
                    } else  {
                        currentBalanceOfTokenUsed := currentBal.balance;
                    };
                };
                bufferBalances.add({
                    token = escrow.token; 
                    balance = currentBalanceOfTokenUsed + escrow.amount - escrow.platformFee: Nat
                });
                let updatedBalances = Buffer.toArray<Types.Balance>(bufferBalances);
                ignore Map.put<Principal, [Types.Balance]>(withdrawableBalances, phash, escrow.userAssigned, updatedBalances);
                return true
            }
        };
    };

    public shared query ({ caller }) func getMyBalances(): async [Types.Balance] {
        switch (Map.get<Principal, [Types.Balance]>(withdrawableBalances, phash, caller)){
            case null [];
            case ( ?bal ) {bal}
        }
    };

    public shared ({ caller }) func withdrawal({token: Principal; amount: Nat; to: Account}): async {#Ok: Nat; #Err} {
        let balances = Map.get<Principal, [Types.Balance]>(withdrawableBalances, phash, caller);
        switch (balances) {
            case null {
                return #Err;
            };
            case ( ?userBalances ) {
                for (b in userBalances.vals()){
                    if (b.token == token ) {
                        let ledger = remoteLedger(token);
                        let feeToken = await ledger.icrc1_fee();
                        if (b.balance >= amount + feeToken) {
                            let transferResponse = await ledger.icrc1_transfer({
                                amount;
                                created_at_time = null;
                                fee = null;
                                from_subaccount = ?"escrows0000000000000000000000000";
                                memo = ?newMemo();
                                to : Account
                            });
                            switch (transferResponse) {
                                case (#Err(_)) {
                                    return #Err;
                                };
                                case (#Ok(index)) {
                                    let updatedUserBalances = Array.tabulate<Types.Balance>(
                                        userBalances.size(),
                                        func i = if (userBalances[i].token == token) {
                                            {userBalances[i] with balance = userBalances[i].balance - (amount + feeToken): Nat}
                                        } else {
                                            userBalances[i]
                                        }
                                    );
                                    ignore Map.put<Principal, [Types.Balance]>(
                                        withdrawableBalances, 
                                        phash, 
                                        caller, 
                                        updatedUserBalances
                                    );
                                    return #Ok(index);
                                }
                            }
                        }
                    }
                };
                return #Err;
            };
        };
        
    }
}

