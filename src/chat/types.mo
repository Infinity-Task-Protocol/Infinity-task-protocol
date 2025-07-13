import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Array "mo:base/Array";
import List "mo:base/List";
import Order "mo:base/Order"

module {
    
    public type InitArgs = {
        mainPlatform: Principal; 
    };

    public type Scope = {
        name: Text;
        id: Text;
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

    // func isInArray(arr: [Principal], a: Principal): Bool {
    //     for(p in arr.vals()) if (a == p) return true;
    //     false
    // };
    
    public type Self = (Principal) -> async actor { 
        getChatId : shared query ([Principal], Text) -> async Nat;
    }

}