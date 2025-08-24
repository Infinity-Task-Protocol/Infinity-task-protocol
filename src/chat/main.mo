import Types "./types";
import Map "mo:map/Map";
import { n32hash; phash } "mo:map/Map";
import { now } "mo:base/Time";
import Array "mo:base/Array";
import List "mo:base/List";
import Principal "mo:base/Principal";

shared ({caller = superAdmin}) persistent actor class ChatCanister(initArgs: Types.InitArgs) = this {

    type Chat = Types.Chat;
    type ChatId = Types.ChatId;
    type Participant = Types.Participant;
    type MsgContent = Types.MsgContent;
    type Msg = Types.Msg;
    

    let chats = Map.new<ChatId, Chat>();
    var userNames = Map.new<Principal, Text>();
    transient let notifications = Map.new<Principal, [Types.Notification]>();

    ////////////////////// Main canister comunications ///////////////////////////////

    public shared ({ caller }) func addUser(u: Principal, name: Text) {
        assert (caller == initArgs.mainPlatform);
        ignore Map.put<Principal, Text>(userNames, phash, u, name)
    };

    public shared ({ caller }) func removeUser(u: Principal) {
        assert (caller == initArgs.mainPlatform);
        Map.delete<Principal, Text>(userNames, phash, u);
    };

    public shared ({ caller }) func setUsers(users: [(Principal, Text)]): async {#Ok; #Err: Text}{
        assert(caller == initArgs.mainPlatform);
        userNames := Map.fromIter<Principal, Text>(users.vals(), phash);
        #Ok
    };

    public shared query ({ caller }) func getUsers(): async [(Principal, Text)]{
        assert(caller == superAdmin);
        Map.toArray<Principal, Text>(userNames)
    };

    ///////////////////////////// Info  //////////////////////////////////////
    public query func getMainPlatform(): async Principal {
        initArgs.mainPlatform
    };

    ///////////////////////////// Private functions //////////////////////////

    func isUser(p: Principal): Bool {
        Map.has<Principal, Text>(userNames, phash, p)
    };

    func callerIncluded(c: Principal, _users: [{name: Text; principal: Principal}]): Bool{
        for(user in _users.vals()){
            if(user.principal == c) { return true }
        };
        return false
    };

    func getUserName(p: Principal): Text {
        switch (Map.get<Principal, Text>(userNames, phash, p)) {
            case null { "Unknown" };
            case (?name) { name }
        }
    };

    func pushNotificationFromChatCanister(user: Principal, n: Types.Notification) {
        let uersNotifications = Map.get<Principal, [Types.Notification]>(notifications, phash, user);
        let notifUpdate = switch uersNotifications {
            case null {
                [n]
            };
             case ( ?notif ) {
                Array.tabulate<Types.Notification>(
                    notif.size() + 1,
                    func i = if(i < notif.size()) {notif[i]} else n
                );
             }
        };
        ignore Map.put<Principal, [Types.Notification]>(notifications, phash, user, notifUpdate);
    };

    func indexOf<P> (u: P, _users: [P], equal: (P, P) -> Bool): ?Nat {
        var index = 0;
        for (user in _users.vals()){
            if (equal(user, u)) { return ?index };
            index += 1;
        };
        null;
    };

    ///////////////// Chat ///////////////////////////////////////////////////

    public shared ({ caller = principal }) func initChat(principalUsers: [Principal], msgContent: MsgContent ): async {#Ok: ChatId; #Err} {
        assert(isUser(principal));
        let user = Map.get<Principal, Text>(userNames, phash, principal);
        switch user {
            case null {#Err};
            case ( ?user ) {

                let {chatId; sortedUsers; senderIndex} = Types.generateDataFromUsers(principalUsers, principal);
                let chat = Map.get<ChatId, Chat>(chats, n32hash, chatId);
                switch chat {
                    case null {
                        let users = Array.map<Principal, {name: Text; principal:Principal}>(
                            sortedUsers, 
                            func x = {name = getUserName(x); principal = x}
                        );
                        let msg = {msgContent with date = now(); sender = senderIndex; indexMsg = 0; read = false};
                        ignore Map.put<ChatId, Chat>(chats, n32hash, chatId, {users; msgs = List.make<Msg>(msg)});
                    };
                    case (?chat) {
                        let msg = {msgContent with date = now(); sender = senderIndex; indexMsg = List.size(chat.msgs); read = false};
                        let updateMsgs = List.push<Msg>(msg, chat.msgs);
                        ignore Map.put<ChatId, Chat>(chats, n32hash, chatId, {chat with msgs = updateMsgs});
                    }
                };
                let sender = {name = user; principal};
                let notification = {
                    date = now();
                    read = false;
                    kind = #Msg({
                      sender with
                      nameSender = user;
                      chatId;} 
                    )
                };
                for (user in principalUsers.vals()){
                    pushNotificationFromChatCanister(user, notification)
                };
                #Ok(chatId)
            }
        };
    };

    public shared ({ caller = principal }) func putMsgToChat(chatId: Nat32, msgContent: MsgContent): async {#Ok; #Err: Text} {
        let chat = Map.get<ChatId, Chat>(chats, n32hash, chatId);
        switch chat {
            case null { #Err("Chat not found") };
            case (?chat) {
                let senderIndex = indexOf<Principal>(
                    principal,
                    Array.map<Types.Participant, Principal>(
                        chat.users, 
                        func x = x.principal
                    ), 
                    Principal.equal          
                );
                switch senderIndex {
                    case null { return #Err("Caller not included in chat") };
                    case (?senderIndex) {
                        let msg = {msgContent with date = now(); sender = senderIndex; indexMsg = List.size(chat.msgs); read = false};
                        let updateMsgs = List.push<Msg>(msg, chat.msgs);
                        ignore Map.put<ChatId, Chat>(chats, n32hash, chatId, {chat with msgs = updateMsgs});
                        let sender = {name = chat.users[senderIndex].name; principal};
                        let notification = {
                            date = now();
                            read = false;
                            kind = #Msg({ sender with chatId;})
                        };
                        let principalUsers = Array.map<{name: Text; principal:Principal}, Principal>(
                                chat.users, 
                                func x = x.principal
                        );
                        for (user in principalUsers.vals()){
                            pushNotificationFromChatCanister(user, notification)
                        };
                        #Ok
                    }
                }   
            }
        }
    };

    public shared query ({ caller }) func readPaginateChat(id: ChatId, page: Nat): async Types.ReadChatResponse{
        let chat = Map.get<ChatId, Chat>(chats, n32hash, id);
        switch chat {
            case null { #Err("Chat not found") };
            case ( ?chat ) {
                if (not callerIncluded(caller, chat.users)) { return #Err("Caller is not included in this chat") };
                let msgsQty = List.size(chat.msgs);
                let lengthResponse = if (msgsQty >= 10 * page + 10) { 10 } else { msgsQty % 10};
                let msgs = Array.subArray<Msg>(List.toArray(chat.msgs), 10 * page, lengthResponse);
                return #Ok({msgs; moreMsg = msgsQty > 10 * page; users = chat.users} )
            }
        }
    };

    public shared query({ caller }) func getMyNotifications(): async [Types.Notification]{
        return switch (Map.get<Principal, [Types.Notification]>(notifications, phash, caller)){
            case null {[]};
            case (?notif) { notif}
        }
    };

    public shared ({ caller }) func markAsRead(date: Int): async {#Ok; #Err: Text}{
        let userNotifications = switch (Map.get<Principal, [Types.Notification]>(notifications, phash, caller)){
            case null {[]};
            case (?n) {n}
        };
        if(userNotifications.size() == 0) {
            return #Err("There are no notifications")
        };
        let updateNotifications = Array.map<Types.Notification, Types.Notification>(
            userNotifications,
            func n = if (n.date == date) {{n with read = true}} else {n}
        );
        ignore Map.put<Principal,[Types.Notification]>(notifications, phash, caller, updateNotifications);
        #Ok
    };

    public shared ({ caller }) func deleteNotification(date: Int): async {#Ok; #Err: Text}{
        let userNotifications = switch (Map.get<Principal, [Types.Notification]>(notifications, phash, caller)){
            case null {[]};
            case (?n) {n}
        };
        if(userNotifications.size() == 0) {
            return #Err("There are no notifications")
        };
        let updateNotifications = Array.filter<Types.Notification>(
            userNotifications,
            func n =  (n.date == date)
        );
        ignore Map.put<Principal,[Types.Notification]>(notifications, phash, caller, updateNotifications);
        #Ok
    };

    

}