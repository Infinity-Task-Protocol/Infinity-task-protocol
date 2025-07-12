import Types "types";
import { now } "mo:base/Time";
import Array "mo:base/Array";
import List "mo:base/List";
import Map "mo:map/Map";
import { phash; nhash } "mo:map/Map";
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import Nat64 "mo:base/Nat64";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import LedgerTypes "../interfaces/ICP_Token/ledger_icp";


shared ({caller = superAdmin}) actor class Treasury(initArgs: Types.InitArgs) = this {

    /////////////////////////////////////////// Types ////////////////////////////////////////////////////////

    type Account = Types.Account;
    type ActivityLogEntry = Types.ActivityLogEntry;
    type WhitdrawalLogEntry = Types.WhitdrawalLogEntry;

    /////////////////////////////////////// Variables state /////////////////////////////////////////////////

    stable var admins: [Principal] = [superAdmin];
    stable var activityLog: List.List<ActivityLogEntry> = List.nil<ActivityLogEntry>();
    stable var withdrawalLog: List.List<WhitdrawalLogEntry> = List.nil<Types.WhitdrawalLogEntry>();
    stable var internalSubaccounts: [Blob] = [
        "feecollector00000000000000000000",
        "escrows0000000000000000000000000",
    ];
    stable let escrows = Map.new<Types.EscrowId, Types.Escrow>();
    stable let token_icp_canister_id = Principal.fromText("ryjl3-tyaaa-aaaaa-aaaba-cai");
    stable var lastEscrowId = 0;
    stable var lastMemoTransactionId = 0;

    stable var withdrawableBalances = Map.new<Principal, [Types.Balance]>();

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

    // public shared ({ caller }) func internalBalances(): async [Types.Balance] {
    //     assert isAdmin(caller);
    //     let bufferBalances = Buffer.fromArray<Types.Balance>([]);
    //     for (subaccount in internalSubaccounts.vals()) {
    //         let account = {owner = Principal.fromActor(this); subaccount = ?subaccount};
    //         let balance = await remoteLedger(token_icp_canister_id).icrc1_balance_of(account);
    //         bufferBalances.add((account, balance))
    //     };
    //     Buffer.toArray<Types.Balance>(bufferBalances)  
    // };

    public shared query ({ caller }) func balancesOf(p: Principal): async ?[Types.Balance] {
        assert isAdmin(caller);
        Map.get<Principal, [Types.Balance]>(withdrawableBalances, phash, p)
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

    public shared query ({ caller }) func getDepositAccount(u: Principal): async Account{
        assert isAdmin(caller);
        getAccountByUser(u)
    };

    //////////////////////////////////// Public Functions ///////////////////////////////////////////////////

    public query func getAdmins(): async [Principal]{
        admins
    };

    public shared query ({ caller }) func getMyDepositAccount(): async Account {
        assert (not Principal.isAnonymous(caller));
        getAccountByUser(caller)
    };

    func verifyTransaction(args: LedgerTypes.TransferArg, blocks: [LedgerTypes.CandidBlock]): Bool {
        for ({ transaction } in blocks.vals()){
            let memo = transaction.icrc1_memo;
            switch (transaction.operation){
                case (? #Transfer(t)) {
                    let toVerified = t.to == Principal.toLedgerAccount(args.to.owner, args.to.subaccount);
                    let amountVerified = t.amount == {e8s = Nat64.fromNat(args.amount)};
                    let memoVerified = memo == args.memo;
                    if (toVerified and amountVerified and memoVerified){
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
                var flagUpdated = false;
                for (balance in currentUserBalances.vals() ) {
                    if (balance.token != escrow.token) {
                        bufferBalances.add(balance);
                    } else  {
                        bufferBalances.add({balance with balance = balance.balance + escrow.amount - escrow.platformFee: Nat});
                        flagUpdated := true;
                    };
                };
                if (not flagUpdated) {
                    bufferBalances.add({token = escrow.token; balance = escrow.amount - escrow.platformFee: Nat});
                };
                let updatedBalances = Buffer.toArray<Types.Balance>(bufferBalances);
                ignore Map.put<Principal, [Types.Balance]>(withdrawableBalances, phash, escrow.userAssigned, updatedBalances);
                return true
            }
        };
    };

    public shared query ({ caller }) func getMyBalances(): async ?[Types.Balance] {
        Map.get<Principal, [Types.Balance]>(withdrawableBalances, phash, caller) 
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

