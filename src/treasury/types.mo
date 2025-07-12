import LedgerTypes "../interfaces/ICP_Token/ledger_icp";

module {

    public type InitArgs = {
        mainPlatform: Principal; 
    };

    public type Account = {
        owner: Principal; 
        subaccount: ?Blob;
    };

    public type Token = {
        name: Text;
        symbol: Text;
        logo: Blob;
        fee: Nat;
        decimals: Nat;
        canisterId: Principal
    };

    public type MetadataValue = {
        #Int : Int;
        #Nat : Nat;
        #Blob : Blob;
        #Text : Text;
    };

    public type AccountIdentifier = Text;

    public type ActivityLogEntry = {
        timestamp: Int;
        caller: Principal;
        action: Action;
    };

    public type Action = {
        #AddAdmin: Principal ;
        #RemoveAdmin: Principal;
        #Other: Text;
    };

    // public type Balance = (Account, Nat);
    public type Balance = {
        token: Principal;
        balance: Nat;
    };

    public type PlatformFee = {
        fixedPart : Nat;
        permilePart  : Nat;
    };

    public type EscrowId = Nat;

    public type CreateEscrowArgs = {
        index: Nat64; 
        transferArg: LedgerTypes.TransferArg;
        platformFee: Nat;
        token: Principal;
        userAssigned: Principal;
    };

    public type Escrow = {
        id: EscrowId;
        token: Principal;
        amount: Nat;
        platformFee: Nat;
        fromSubaccount: Blob;
        // to: {#Account: Account; #AccountIdentifier: AccountIdentifier};
        userAssigned: Principal;
    };

    public type WhitdrawalLogEntry = {
        timestamp: Int;
        caller: Principal;
        amount: Nat;
        fromSubaccount: ?Blob;
        to: {#Account: Account; #AccountIdentifier: AccountIdentifier};
    };

    public type WithdrawalsError = {
        #InvalidAddress;
        #InsufficientBalance;
        #Other : Text;
    };

    public type BlockIndex = Nat64;

    public type WithdrawalResult = { 
        #ok : BlockIndex;
        #err : WithdrawalsError 
    };
    


}