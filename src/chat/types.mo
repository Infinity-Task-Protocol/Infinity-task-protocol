import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Array "mo:base/Array";
import List "mo:base/List";
import Order "mo:base/Order";
import Set "mo:map/Set";
import { phash } "mo:map/Map";

module {
    
    public type InitArgs = {
        mainPlatform: Principal; 
    };

    public type ChatId = Nat32; //Hash concatenation of principals ordered from lowest to highest + textScope. See getChatId function

    public type Participant = {
        name: Text; 
        principal:Principal
    };

    public type Notification = {
        date: Int;
        read: Bool;
        kind: {
            #Msg: Participant and {chatId: ChatId};
        } 
    };

    public type Chat = { 
        users : [Participant];
        msgs : List.List<Msg>;
    };

    public type ReadChatResponse = {
        #Ok: {
            msgs: [Msg];
            users: [Participant];
            moreMsg: Bool;    
        };
        #Err: Text;
    };

    public type Scope = {
        name: Text;
        id: Text;
    };

    public type Media = {
        #Image: Blob;
        #Audio: Blob;
        #Video: Blob;
    };

    public type MediaId = Nat;

    public type BuketId = Principal;

    public type StorageLocation = {
        buket : BuketId;
        index : Nat;
    };

    public type MsgContent = {
        msg : Text;
        multimedia : ?StorageLocation;
    };

    public type Msg = MsgContent and {
        date: Int;
        sender: Nat; // user referenced by their index in the list of users
        indexMsg: Nat;  // index of the message in the list of messages
        read: Bool;
    };

    func uniqueSorted<T>(users: [T], compare: (T, T) -> Order.Order): [T] {
        let sortedArr = Array.sort<T>(users, compare);
        let size = sortedArr.size();
        if(size == 0) return [];
        var listResult = List.make<T>(sortedArr[0]);
        var lastAdded = sortedArr[0];
        var index = 1;
        while (index < size) {
            let currentElement = sortedArr[index];
            if(compare(currentElement, lastAdded) != #equal) {
                listResult := List.push<T>(currentElement, listResult)
            };
            index += 1;
        };
        List.toArray<T>(List.reverse(listResult))
    };

    public func generateDataFromUsers(users: [Principal], sender: Principal): {chatId: Nat32; sortedUsers: [Principal]; senderIndex: Nat} {
        let usersSet = Set.fromIter<Principal>(users.vals(), phash);
        ignore Set.put<Principal>(usersSet, phash, sender);
        let sortedUsers = Array.sort<Principal>(
            Set.toArray<Principal>(usersSet),
            Principal.compare
        );
        var usersPrehash = "";
        var index = 0;
        var senderIndex = 0;
        
        for(user in sortedUsers.vals()){
            usersPrehash #= Principal.toText(user);
            if (user == sender) { senderIndex := index };
            index += 1;
        };
        let chatId = Text.hash(usersPrehash);
        {chatId; sortedUsers; senderIndex}
    };

    public func getChatId(caller: Principal, interlocutors: [Principal], scope: ?Scope): Nat32 {
        let users = Array.tabulate<Principal>(
            interlocutors.size() +1,
            func i = if (i < interlocutors.size()) { interlocutors[i] } else { caller }
        );
        let sortedUsers = uniqueSorted<Principal>(users, Principal.compare);
        var accumulator = "";
        for (user in sortedUsers.vals()) {
            accumulator #= Principal.toText(user);
        };
        accumulator #= switch scope {
            case null "";
            case (?{name; id}) { name # id } 
        };
        Text.hash(accumulator);
    };

    
    public type Self = (Principal) -> async actor { 
        getChatId : shared query ([Principal], Text) -> async Nat;
    }

}