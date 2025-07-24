import Principal "mo:base/Principal";
import Map "mo:map/Map";
import TreasuryTypes "../treasury/types";
module {

    type Account = { owner : Principal; subaccount : ?Blob };

    public type User = {
        principal : Principal;
        name : Text;
        avatar : ?Blob;
        coverImage: ?Blob;
        bio: ?Text;
        email : ?Text;
        socialLinks : [Text];
        verified : Bool;
        score : Nat;
        walletAccount : ?Account;
        tasks : [Nat];
        position: ?Text;
        skills: [Text];
    };

    public type UserUpdatableData = {
        name : ?Text;
        avatar : ?Blob;
        coverImage: ?Blob;
        email : ?Text;
        socialLinks : [Text];
        position: ?Text;
        bio: ?Text;
        skills: [Text];
    };

    public func DefaultUser() : User {
        {
            principal = Principal.fromText("2vxsx-fae");
            name = "";
            avatar = null;
            coverImage = null;
            email = null;
            verified = false;
            score = 0;
            walletAccount = null;
            tasks = [];
            position = null;
            bio = null;
            skills = [];
            socialLinks = [];
        };
    };

    public type Notification = {
        date : Int;
        read : Bool;
        kind: KindNotification;
    };

    public type KindNotification = {
        #NewBid: Nat;
        #TaskDelivered : Nat;
        #DeliveryAccepted: Nat;
    };

    public type Msg = {
        date : Int;
        sender : Principal;
        content : Text;
        read : Bool;
    };

    public type CertificateDataInit = {
        title : Text;
        description : Text;
        image: ?Blob;
        expirationDate : ?Int;
    };

    public type Certificate = CertificateDataInit and {
        id : Nat;
        owner : Principal;
        expeditionDate : Int;
    };

    public type LoginResult = {
        #Ok : ({
            user : User;
            notifications : [Notification];
            msgs : [Msg];
            certificates : [Certificate];
        });
        #Err : Text;
    };

    public type Asset = {
        mimeType : Text;
        data : Blob;
    };

    public type File = Asset and {
        id: Nat;
        withAccess: [Principal];
    };

    type Timestamp = Int;
    public type TaskStatus = {
        #ToDo: Timestamp;
        #AcceptedOffer: Timestamp;
        #PaymentDepositDone: Timestamp;
        #InProgress: Timestamp;
        #Delivered: Timestamp;
        #ReleasingPayment;
        #Cancelled: Timestamp;
        #Done: Timestamp;
    };

    public type TaskDataInit = {
        title : Text;
        description : Text;
        keywords : [Text];
        rewardRange : (Nat, Nat);
        token: TreasuryTypes.Token;  // selector en el front con los tokens soportados getTokensSupported() -> [Token]
        assets : [Asset];
    };

    public type Offer = {
        amount : Nat;
        date : Int;
    };

    public type TaskExpand = TaskDataInit and {
        id : Nat;
        owner : Principal;
        createdAt : Int;
        status : TaskStatus;
        assignedTo : ?Principal;
        bidsCounter : Nat;
        chatId: ?Nat32;
    };

    public type TaskPreview = {
        id : Nat;
        owner : Principal;
        status : TaskStatus;
        title : Text;
        description : Text;
        keywords : [Text];
        rewardRange : (Nat, Nat);
        token: TreasuryTypes.Token;
        createdAt : Int;
        bidsCounter : Nat;
    };

    public type Task = TaskExpand and {
        bids : Map.Map<Principal, Offer>;
        finalAmount : Nat;
        payed: Bool;
        memoTransaction: ?Blob;
        start : ?Int;
        chatId: ?Nat32;
        deliveries: [Nat];
    };

    public type UpdatableDataTask = {
        title : Text;
        description : Text;
        rewardRange : (Nat, Nat);
    };

    public type DeliveryTask = {
        id: Nat;
        taskId: Nat;
        taskOwner: Principal;
        assets: [Asset];
        date: Int;
        description: Text;
        qualification: ?Nat8;
        review: ?Text;
    };
    
    public type AcceptedDeliveryArgs = {
        deliveryId: Nat;
        qualification: Nat8;
        review: Text;
    };

    public func defaultTask() : Task {
        {
            id = 0;
            owner = Principal.fromText("2vxsx-fae");
            assets = [];
            assignedTo = null;
            bids = Map.new<Principal, Offer>();
            bidsCounter = 0;
            createdAt = 0;
            description = "";
            finalAmount = 0;
            payed = false;
            memoTransaction = null;
            keywords = [];
            rewardRange = (0, 0);
            token = TreasuryTypes.icpToken();
            start = null;
            status = #ToDo(0);
            title = "";
            chatId = null;
            deliveries = [];
        }

    }

};
