import Types "./types";
import Map "mo:map/Map";
import { phash; nhash } "mo:map/Map";
import Principal "mo:base/Principal";
import { now } "mo:base/Time";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Random "mo:random/Rand";
import { print } "mo:base/Debug";
import Nat64 "mo:base/Nat64";
import Blob "mo:base/Blob";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Int "mo:base/Int";
import Ledger "../interfaces/ICP_Token/ledger_icp";
// import icrc2 "../interfaces/icrc2";
import TreasuryTypes "../treasury/types";
import ChatTypes "../chat/types";
import Utils "./utils";

shared ({ caller = DEPLOYER }) persistent actor class () {

  type User = Types.User;
  type UserUpdatableData = Types.UserUpdatableData;
  type LoginResult = Types.LoginResult;
  type BidsResult = Types.BidsResult;
  type TaskDataInit = Types.TaskDataInit;
  type Task = Types.Task;
  type TaskPreview = Types.TaskPreview;
  type AcceptOfferResponse = Types.AcceptOfferResponse;

  let users = Map.new<Principal, User>();
  
  let notifications = Map.new<Principal, [Types.Notification]>();
  let msgs = Map.new<Principal, [Types.Msg]>();
  let activeTasks = Map.new<Nat, Types.Task>();
  let archivedTasks = Map.new<Nat, Types.Task>();
  let deliveries = Map.new<Nat, Types.DeliveryTask>();
  let certificates = Map.new<Principal, [Types.Certificate]>();
  var admins: [Principal] = [DEPLOYER];
  
  //////////////// Temporal Variables //////////////////////

  transient let verificationCodes = Map.new<Principal, Nat>();
  let transferArgsByTask = Map.new<Nat, AcceptOfferResponse>();
  //////////////// Platform Variables //////////////////////

  var platformFee: TreasuryTypes.PlatformFee = {
    fixedPart = 10_000_000; // 0.1 ICP
    permilePart = 56 // 56 permile -> 5.6% ammount
  };


  ///////////// Canisters ids /////////////

  var treasuryCanisterId: Principal = Principal.fromText("2vxsx-fae");
  var chatCanisterId: Principal = Principal.fromText("2vxsx-fae"); 
  
  ////////////////////////////////////////
  transient let rand = Random.Rand();

  ///////////////// State variables ////////////////////////

  var lastTaskId = 0;
  var lastDeliveryTask = 0;
  var lastCertificateId = 0;
  var lastMemoTransactionId = 0;

  /////////// Separar hacia un canister bucket /////////////

  let files = Map.new<Nat, Types.File>();
  var lastFileId = 0;

  ////////////////// Settings functions ///////////////////

  public shared ({ caller }) func addAdmin(p: Principal): async {#Ok; #Err} {
    assert(isAdmin(caller));
    if (not isAdmin(p)){
      admins := Array.tabulate<Principal>(
        admins.size() + 1,
        func a = if (a < admins.size()) { admins[a] } else { p },
      );
      return #Ok;
    };
    #Err;
  };

  public shared ({ caller }) func setPlatformFee({fixedPart: Nat; amountPermile: Nat}): async {#Ok; #Err: Text} {
    assert(isAdmin(caller));
    if(fixedPart < 10_000 or fixedPart > 100_000_000) {
      return #Err("Fixed part must be between 10_000 and 100_000_000 (0.001 to 1 ICP)");
    };
    if (amountPermile < 10 or amountPermile > 200) {
      return #Err("Amount amountPermile must be between 10 and 200 (1% to 20%)");
    };
    platformFee := {fixedPart; permilePart = amountPermile};
    #Ok
  };

  public shared ({ caller }) func setTreasuryCanisterId(p: Principal): async {#Ok} {
    assert isAdmin(caller) and Principal.isAnonymous(treasuryCanisterId);
    treasuryCanisterId := p;
    #Ok
  };

  public shared ({ caller }) func setChatCanisterId(p: Principal): async {#Ok} {
    assert isAdmin(caller) and Principal.isAnonymous(chatCanisterId);
    chatCanisterId := p;
    #Ok
  };

  public shared ({ caller }) func syncUsersInCanisterChat(): async {#Ok; #Err: Text}{
    assert(isAdmin(caller));
    if(Principal.isAnonymous(chatCanisterId)){
      return #Err("Chat canister ID not configured")
    };
    let chatActor = actor(Principal.toText(chatCanisterId)): actor {
      setUsers: shared [(Principal, Text)] -> async {#Ok; #Err: Text}
    };
    let userNames = Array.map<(Principal, User), (Principal, Text)>(
      Map.toArray<Principal, User>(users),
      func u = (u.0, u.1.name)
    );
    await chatActor.setUsers(userNames)
  };

  ////////////////// Admin functions /////////////////////

  public shared ({ caller }) func certifyUser(user: Principal, certificate: Types.CertificateDataInit) : async () {
    assert(Map.has<Principal, User>(users, phash, user));
    assert(isAdmin(caller));
    let {title; description; expirationDate; image } = certificate;
    lastCertificateId += 1;
    let newCertificate: Types.Certificate = {
      title;
      description;
      image;
      expirationDate;
      id = lastCertificateId;
      owner = user;
      expeditionDate = now();
    };
    let currentCertificates = switch(Map.get<Principal, [Types.Certificate]>(certificates, phash, user)){
      case null [];
      case (?c) c;
    };
    let updateCertificates = Array.tabulate<Types.Certificate>(
      currentCertificates.size() + 1,
      func x = if (x < currentCertificates.size()) { currentCertificates[x] } else { newCertificate }
    );
    ignore Map.put<Principal, [Types.Certificate]>(certificates, phash, user, updateCertificates);

  };

  ///////////////// User functions //////////////////////

  public shared ({ caller }) func signUp({ name : Text/* ; email: Text */}) : async LoginResult {
    if (Principal.isAnonymous(caller)) {
      return #Err("Caller anonymous");
    };
    switch (Map.get<Principal, User>(users, phash, caller)) {
      case null {
        let newUser = {
          Types.DefaultUser() with name;
          principal = caller /* ; email = ?email */;
        };
        ignore Map.put<Principal, User>(users, phash, caller, newUser);

        // Register user name in canister chat
        if(not Principal.isAnonymous(chatCanisterId)){
          let chatActor = actor(Principal.toText(chatCanisterId)): actor {
            addUser: shared (Principal, Text) -> async {#Ok; #Err: Text}
          };
          ignore chatActor.addUser(caller, name)
        };
        ////

        return #Ok({
          user = newUser;
          notifications = [];
          msgs = [];
          certificates = [];
        });
      };
      case (?user) {
        #Ok({
          user;
          notifications = getNotifications(caller);
          msgs = getMsgs(caller);
          certificates = switch (Map.get<Principal, [Types.Certificate]>(certificates, phash, caller)){
            case null [];
            case (?c) c;
          };
        });
      };
    };
  };

  public shared query ({ caller }) func signIn() : async LoginResult {
    switch (Map.get<Principal, User>(users, phash, caller)) {
      case null { #Err("User not found") };
      case (?user) {
        #Ok({
          user;
          notifications = getNotifications(caller);
          msgs = getMsgs(caller);
          certificates = switch (Map.get<Principal, [Types.Certificate]>(certificates, phash, caller)){
            case null [];
            case (?c) c;
          };
        });
      };
    };
  };

  public shared query ({ caller }) func pullingNotifications(): async [Types.Notification]{
    getNotifications(caller)
  };

  public shared ({ caller }) func markNotificationAsRead(date: Int): async (){
    let userNotifications = getNotifications(caller);
    if (userNotifications.size() == 0) { return };
    var requiresUpdate = false;
    let updatedNotifications = Array.map<Types.Notification, Types.Notification> (
      userNotifications,
      func n = if (n.date == date) {
        requiresUpdate := true;
        {n with read = true}
      } else { 
        n 
      }
    );
    if(requiresUpdate){
      ignore Map.put<Principal, [Types.Notification]>(notifications, phash, caller, updatedNotifications)
    }
  };

  public shared ({ caller }) func editProfile(data : UserUpdatableData) : async {
    #Ok : User;
    #Err : Text;
  } {
    let user = switch (Map.get<Principal, User>(users, phash, caller)) {
      case null { return #Err("User not found") };
      case (?user) { user };
    };
    let {
      name;
      email;
      avatar;
      thumbnail;
      position;
      skills;
      bio;
      socialLinks;
      coverImage;
    } = data;
    let verified = (user.email == email) and (email != null); // En caso de que el usuario modifique su email tendrá que verificarlo nuevamente
    let updatedUser = {
      user with
      verified;
      name = switch (name) { case null user.name; case (?n) n };
      email = switch (email) { case null user.email; case (e) e };
      avatar = switch (avatar) { case null user.avatar; case (a) a };
      thumbnail = switch (thumbnail) { case null user.thumbnail; case (t) t };
      position = switch (position) { case null user.position; case (p) p };
      bio = switch (bio) { case null user.bio; case (b) b };
      coverImage;
      socialLinks;
      skills;
    };
    ignore Map.put<Principal, User>(users, phash, caller, updatedUser);
    #Ok(updatedUser);
  };

  public shared ({ caller }) func loadAvatar(avatar: ?Blob, thumbnail: ?Blob): async ?User {
    let user = Map.get<Principal, User>(users, phash, caller);
    switch user {
      case null { null };
      case (?user) {
        ignore Map.put<Principal, User>(users, phash, caller, { user with avatar; thumbnail });
        ?{ user with avatar; thumbnail };
      };
    };
  };

  public shared ({ caller }) func getVerificationCode() : async ?Nat {
    switch (Map.get<Principal, User>(users, phash, caller)) {
      case null { return null };
      case (_) {
        rand.setRange(100000, 999999);
        let code = await rand.next();
        ignore Map.put<Principal, Nat>(verificationCodes, phash, caller, code);
        ?code;
      };
    };
  };

  public shared ({ caller }) func enterCodeVerification(code : Nat) : async Bool {
    switch (Map.get<Principal, User>(users, phash, caller)) {
      case null false;
      case (?user) {
        if (verifyCode(caller, code)) {
          ignore Map.put<Principal, User>(users, phash, caller, { user with verified = true });
          true;
        } else {
          false;
        };
      };
    };
  };

  /////////////////// Public functions //////////////////////

  public shared ({ caller }) func getUser(u : Principal) : async ?User {
    assert (isAdmin(caller));
    Map.get<Principal, User>(users, phash, u);
  };

  public shared func getCertifiesByPrincipal(p : Principal) : async [Types.Certificate] {
    switch (Map.get<Principal, [Types.Certificate]>(certificates, phash, p)) {
      case null [];
      case (?c) { c };
    };
  };

  ///////////////// Crud Tasks //////////////////

  public shared ({ caller }) func createTask(data : TaskDataInit) : async {
    #Ok : Nat;
    #Err : Text;
  } {
    assert (not Principal.isAnonymous(caller));
    let user = switch (Map.get<Principal, User>(users, phash, caller)) {
      case null { return #Err("Caller is not User") };
      case (?user) {
        user;
      };
    };
    let { description; keywords; rewardRange; title; assets } = data;

    lastTaskId += 1;

    let newTask : Task = {
      Types.defaultTask() with
      owner = caller;
      id = lastTaskId;
      createdAt = now();
      description;
      keywords;
      rewardRange;
      title;
      assets;
    };

    ignore Map.put<Nat, Task>(activeTasks, nhash, lastTaskId, newTask);

    let updatedUser: User = {
      user with
      tasks = Array.tabulate<Nat>(
        user.tasks.size() + 1,
        func(i) {
          if (i == user.tasks.size()) { lastTaskId } else { user.tasks[i] };
        },
      )
    };
    ignore Map.put<Principal, User>(users, phash, caller, updatedUser);
    return #Ok(newTask.id);
  };

  public shared query func getPaginateTaskPreview({ page : Nat; qtyPerPage : ?Nat }) : async { arr : [TaskPreview]; hasNext : Bool } {
    let taskArray = Array.reverse(Iter.toArray(Map.vals<Nat, Task>(activeTasks)));
    let _qtyPerPage = switch (qtyPerPage) { case null 50; case (?n) n };

    if (taskArray.size() >= page * _qtyPerPage) {
      let (deliverySize : Nat, hasNext : Bool) = if (taskArray.size() >= (page + 1) * _qtyPerPage) {
        (_qtyPerPage, taskArray.size() > (page + 1));
      } else { (taskArray.size() % _qtyPerPage, false) };

      let subArray = Array.subArray<Task>(
        taskArray,
        page * _qtyPerPage,
        deliverySize,
      );
      {
        arr = Array.map<Task, TaskPreview>(subArray, func x = { x with bidsCounter = Map.size(x.bids) });
        hasNext;
      };
    } else { { arr = []; hasNext = false } };
  };

  type TaskExpandResponse = {
    task: Types.TaskExpand; 
    author: Types.UserPreview; 
    bidsDetails: [(Principal, Types.Offer)]
  };

  public shared query ({caller}) func expandTask(id : Nat) : async ?TaskExpandResponse {
    switch (Map.get<Nat, Task>(activeTasks, nhash, id)) {
      case null null;
      case (?task) {
        let user = switch (Map.get<Principal, User>(users, phash, task.owner)) {
          case null { return null };
          case (?user) user;
        };
        let bidsCounter = Map.size(task.bids);
        let bidsDetails = if (caller == task.owner) { Map.toArray(task.bids) } else {
          [];
        };
        return ?{ task = { task with bidsCounter }; author = user; bidsDetails };
      };
    };
  };

  public shared ({ caller }) func updateTask({id : Nat; data: Types.UpdatableDataTask}) : async { #Ok; #Err: Text } {
    let task = Map.get<Nat, Task>(activeTasks, nhash, id);
    let { title; description; rewardRange } = data;
    switch task {
      case null { return #Err("Task Id not found") };
      case (?task) {
        if (task.owner != caller or task.assignedTo != null) {
          return #Err("Caller is not owner");
        };
        if (Map.size(task.bids) > 0) {
          return #Err("Task with pending bids cannot be updated");
        };
        let updatedTask: Task = {
          task with
          title;
          description;
          rewardRange;
        };
        ignore Map.put<Nat, Task>(activeTasks, nhash, id, updatedTask);
        return #Ok;
      };
    };
  };

  public shared ({ caller }) func deleteTask(id : Nat) : async { #Ok; #Err } {
    let task = Map.remove<Nat, Task>(activeTasks, nhash, id);
    switch task {
      case null { return #Err };
      case (?t) {
        if (t.owner != caller or t.assignedTo != null) {
          ignore Map.put<Nat, Task>(activeTasks, nhash, id, t);
          #Err;
        } else {
          ignore Map.put<Nat, Task>(archivedTasks, nhash, id, t);
          #Ok;
        };
      };
    };
  };

  ////////////////////////////////////////////////////////////

  public shared ({ caller }) func applyForTask({taskId: Nat; amount: Nat}): async {#Ok; #Err: Text}{
    let user = switch(Map.get<Principal, User>(users, phash, caller)){
      case null { return #Err("Caller is not User") };
      case (?user) { user };
    };

    if (not user.verified) { return #Err("User is not verified") };

    let task : Task = switch (Map.get<Nat, Task>(activeTasks, nhash, taskId)) {
      case null { return #Err("Task does not exist") };
      case (?task) { task };
    };

    if (caller == task.owner) { return #Err("Cannot apply for own task") };

    if (task.assignedTo != null) {
      return #Err("Task is already assigned");
    };

    if (amount < task.rewardRange.0 or task.rewardRange.1 < amount) {
      return #Err("Amount offer is out of range");
    };
    print("Applying for task: " # Nat.toText(taskId) # " with amount: " # Nat.toText(amount));
    ignore Map.put<Principal, Types.Offer>(task.bids, phash, caller, { user with date = now(); amount });
    ////// Task Owner Push Notification ///////
    pushNotification(
      task.owner,
      {
        date = now();
        read = false;
        kind = #NewBid(taskId);
      },
    );
    ////////////////////////////////
    #Ok;
  };

  public shared query ({ caller }) func getBids(taskId : Nat) : async BidsResult {
    switch (Map.get<Nat, Task>(activeTasks, nhash, taskId)) {
      case null {
        return #taskNotFound;
      };
      case (?task) {
        if (caller != task.owner) return #unauthorized;
        return #Ok(Map.toArray<Principal, Types.Offer>(task.bids));
      };
    };
  };

  

  public shared ({ caller }) func acceptOffer(taskId : Nat, user : Principal) : async AcceptOfferResponse {

    let task : Task = switch (Map.get<Nat, Task>(activeTasks, nhash, taskId)) {
      case null { return #Err("Task does not exist") };
      case (?task) { task };
    };

    if (task.owner != caller) {
      return #Err("Caller is not the task owner");
    };

    switch (task.status) {
      case (#PaymentDepositDone(_)) {
        return #Err("The task is already being executed");
      };
      case (_) {};
    };

    let offerAccepted = Map.get<Principal, Types.Offer>(task.bids, phash, user);
    switch offerAccepted {
      case null {
        return #Err("User has not made an offer");
      };
      case (?offer) {
        let memo = newMemo();
        let updatedTask : Task = {
          task with
          assignedTo = ?user;
          status = #AcceptedOffer(now());
          finalAmount = offer.amount;
          start = ?now();
          memoTransaction = ?memo.blob;
        };
        ignore Map.put<Nat, Task>(activeTasks, nhash, taskId, updatedTask);

        let transactionArgs : AcceptOfferResponse = #TransactionArgs({ 
          icp = {
            amount = { e8s = Nat64.fromNat(offer.amount) };
            created_at_time = ?{timestamp_nanos = Nat64.fromNat(Int.abs(now()))};
            fee = { e8s = Nat64.fromNat(task.token.fee) };
            from_subaccount = null;
            memo = memo.nat64;
            to : Blob = Principal.toLedgerAccount((treasuryCanisterId, ?"escrows0000000000000000000000000"));
          };
          icrc2 = {
            amount = offer.amount;
            created_at_time = ?Nat64.fromNat(Int.abs(now()));
            fee = ?task.token.fee;
            from_subaccount = null;
            memo = ?memo.blob;
            to = {
              owner = treasuryCanisterId;
              subaccount = ?"escrows0000000000000000000000000";
            };
          }}
        );
        ignore Map.put<Nat, AcceptOfferResponse>(transferArgsByTask, nhash, taskId, transactionArgs);
        transactionArgs;
      };
    };
  };

  public shared ({ caller }) func getTransferArgsForTask(id : Nat) : async ?AcceptOfferResponse {
    switch (Map.get<Nat, Task>(activeTasks, nhash, id)) {
      case null { null };
      case (?task) {
        if (caller != task.owner and not isAdmin(caller)) {
          null;
        } else {
          Map.get<Nat, AcceptOfferResponse>(transferArgsByTask, nhash, id);
        };
      };
    };
  };
  
  public shared ({ caller }) func paymentNotification({taskId : Nat; blockIndex : Nat64}) : async { #Err : Text; #Ok : Nat } {
    let task = Map.get<Nat, Task>(activeTasks, nhash, taskId);
    let acceptedOfferResponse = Map.get<Nat, AcceptOfferResponse>(transferArgsByTask, nhash, taskId);

    switch ((task, acceptedOfferResponse)) {
      case ((?task, ?acceptedOfferResponse)) {
        if (task.owner != caller) {
          return #Err("Caller is not the task owner");
        };
        switch acceptedOfferResponse {
          case (#TransactionArgs(transactionArgs)){
            let toValidate = transactionArgs.icrc2.to == {
              owner = treasuryCanisterId;
              subaccount = ?"escrows0000000000000000000000000";
            };
            let amountValidate = transactionArgs.icrc2.amount == task.finalAmount;
            if (not toValidate or not amountValidate) {
              return #Err("Error in trasfer args");
            }; 
            let treasuryCanister = actor (Principal.toText(treasuryCanisterId)) : actor {
              createEscrow : shared (TreasuryTypes.CreateEscrowArgs) -> async {
                #Ok : Nat;
                #Err : Text;
              };
            };
            let assignedTo = switch (task.assignedTo) {
              case (?user) { user };
              case null { return #Err("Not user assigned") };
            };
            let escrow = await treasuryCanister.createEscrow({
              platformFee = calculateFee(transactionArgs.icrc2.amount);
              index = blockIndex;
              transferArg = transactionArgs.icrc2;
              token = task.token.canisterId;
              userAssigned = assignedTo;
            });

            switch escrow {
              case (#Ok(_)) {
                ignore Map.remove<Nat, AcceptOfferResponse>(transferArgsByTask, nhash, taskId);
                ignore Map.put<Nat, Task>(
                  activeTasks,
                  nhash,
                  taskId,
                  {
                    task with
                    chatId = ?ChatTypes.getChatId(caller, [assignedTo], ?{ id = Nat.toText(taskId); name = "Task" });
                    status = #PaymentDepositDone(now());
                  },
                )

              };
              case (#Err(_)) {};
            };
            // Freelancer push Notification
            pushNotification(
              assignedTo,
              {
                date = now();
                read = false;
                kind = #OfferAccepted(taskId);
              },
            );
              ////////////////////////////////
            escrow;
          };
          case ( #Err(e) ) {
            return #Err(e)
          }
        }
      };
      case (null, _) {
        #Err("Task not found");
      };
      case (_, null) {
        #Err("Transfer args not found");
      };
    };
  };

  public shared ({ caller }) func deliveryTask({taskId: Nat; description: Text; asset: Types.Asset}): async Bool {
    let task = Map.get<Nat, Task>(activeTasks, nhash, taskId);
    switch task {
      case null return false;
      case (?task) {
        switch (task.status) {
          case (#PaymentDepositDone(_t)) {
            if (task.assignedTo != ?caller) {
              return false;
            };

            // lastFileId += 1;
            // let newFile = {
            //   asset with
            //   id = lastFileId;
            //   withAccess = [caller, task.owner]
            // };
            // ignore Map.put<Nat, Types.File>(files, nhash, newFile.id , newFile);
            //// TODO: Crear type para entrega de tarea //////

            lastDeliveryTask += 1;
            let newDelibery : Types.DeliveryTask = {
              description;
              id = lastDeliveryTask;
              date = now();
              taskId;
              taskOwner = task.owner;
              assets = [asset]; // TODO Almacenar los archivos en canisters tipo Bucket y guardar las referencia a su ubicacion: CanisterBucketId y fileID
              qualification = null;
              review = null;
            };
            ignore Map.put<Nat, Types.DeliveryTask>(deliveries, nhash, newDelibery.id, newDelibery);
            ignore Map.put<Nat, Task>(
              activeTasks,
              nhash,
              taskId,
              {
                task with status = #Delivered(now());
                deliveries = Array.tabulate<Nat>(
                  task.deliveries.size() + 1,
                  func i = if (i < task.deliveries.size()) {
                    task.deliveries[i];
                  } else { newDelibery.id },
                );
              },
            );
            ////// Task Owner Push Notification ///////
            pushNotification(
              task.owner,
              {
                date = now();
                kind = #TaskDelivered(newDelibery.id);
                read = false;
              },
            );
            ////////////////////////////////

            ignore Map.put<Nat, Task>(activeTasks, nhash, taskId, { task with status = #Delivered(now()) }); // Agregar el id del archivo adjunto (file)
            true;
          };
          case _ { return false };
        };
      };
    };
  };

  public shared ({ caller }) func checkDelivery(id : Nat) : async {
    #Ok : Types.DeliveryTask;
    #Err : Text;
  } {
    switch (Map.get<Nat, Types.DeliveryTask>(deliveries, nhash, id)) {
      case null { return #Err("Delivery not found") };
      case (?delivery) {
        if (delivery.taskOwner != caller) {
          return #Err("Caller is not the task owner");
        } else {
          return #Ok(delivery);
        };
      };
    };
  };

  public shared ({ caller }) func acceptDelivery(args : Types.AcceptedDeliveryArgs) : async {
    #Ok;
    #Err : Text;
  } {
    let { deliveryId; qualification; review } = args;
    let delivery = Map.get<Nat, Types.DeliveryTask>(deliveries, nhash, deliveryId);
    switch delivery {
      case null { return #Err("Delivery not found") };
      case (?delivery) {
        switch (Map.get<Nat, Task>(activeTasks, nhash, delivery.taskId)) {
          case null { return #Err("Task not found") };
          case (?task) {
            switch (task.status) {
              case (#Delivered(_)) {
                if (task.owner != caller) {
                  return #Err("Caller is not the task owner");
                };
                ignore Map.put<Nat, Task>(activeTasks, nhash, task.id, { 
                  task with status = #ReleasingPayment;
                });
                let treasuryCanister = actor(Principal.toText(treasuryCanisterId)): actor {
                  releaseEscrow: shared Nat -> async Bool;
                };
                let response = await treasuryCanister.releaseEscrow(task.id);
                if (response) {
                  let updateDelivery : Types.DeliveryTask = {
                    delivery with
                    qualification = ?qualification;
                    review = ?review;
                  };
                  ignore Map.put<Nat, Types.DeliveryTask>(deliveries, nhash, deliveryId, updateDelivery);
                  ignore Map.remove<Nat, Task>(activeTasks, nhash, task.id);
                  ignore Map.put<Nat, Task>(archivedTasks, nhash, task.id, { task with status = #Done(now()) });
                };
              };
              case (_) { return #Err("Task is not delivered") };
            };
          };
        };

      };
    };
    #Ok;
  };

  ///////////// private functions ///////////////

  // func isUser(p: Principal): Bool {
  //   Map.has<Principal, User>(users, phash, p)
  // };

  func pushNotification(p : Principal, notif : Types.Notification) {
    let currentNotifications = switch (Map.get<Principal, [Types.Notification]>(notifications, phash, p)) {
      case null { [] };
      case (?n) { n };
    };
    print(debug_show(currentNotifications));

    let updatedNotifications = Array.tabulate<Types.Notification>(
      currentNotifications.size() + 1,
      func i = if (i < currentNotifications.size()) { currentNotifications[i] } else {
        notif;
      },
    );
    print(debug_show(updatedNotifications));
    ignore Map.put<Principal, [Types.Notification]>(notifications, phash, p, updatedNotifications)

  };

  func isAdmin(p : Principal) : Bool {
    for (a in admins.vals()) {
      if (a == p) return true;
    };
    return false;
  };

  func newMemo() : {blob: Blob; nat64: Nat64} {
    lastMemoTransactionId += 1;
    let txnText = Nat.toText(lastMemoTransactionId % 1000000000);
    return {
      blob = Text.encodeUtf8("InfinityTaskProtocolTX:" # txnText);
      nat64 = Nat64.fromNat(lastMemoTransactionId)  
    };
  };

  func calculateFee(amount : Nat) : Nat {
    platformFee.fixedPart + (amount * platformFee.permilePart) / 1000;
  };

  func verifyCode(u : Principal, _code : Nat) : Bool {
    switch (Map.remove<Principal, Nat>(verificationCodes, phash, u)) {
      case null false;
      case (?code) { code == _code };
    };
  };

  func getNotifications(p : Principal) : [Types.Notification] {
    switch (Map.get<Principal, [Types.Notification]>(notifications, phash, p)) {
      case null [];
      case (?n) n;
    };
  };

  func getMsgs(p : Principal) : [Types.Msg] {
    switch (Map.get<Principal, [Types.Msg]>(msgs, phash, p)) {
      case null [];
      case (?m) m;
    };
  };
};
