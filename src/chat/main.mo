import Types "./types";
import Map "mo:map/Map";
import { n32hash; phash } "mo:map/Map";
import { now } "mo:base/Time";
import Array "mo:base/Array";
import List "mo:base/List";

shared ({caller = superAdmin}) persistent actor class ChatCanister(initArgs: Types.InitArgs) = this {

    type Chat = Types.Chat;
    type ChatId = Types.ChatId;
    type Participant = Types.Participant;
    type MsgContent = Types.MsgContent;
    type Msg = Types.Msg;
    

    let chats = Map.new<ChatId, Chat>();
    let userNames = Map.new<Principal, Text>();
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




}