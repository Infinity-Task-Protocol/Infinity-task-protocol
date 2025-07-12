import Types "./types";
import Map "mo:map/Map";
import { phash; nhash } "mo:map/Map";
import Principal "mo:base/Principal";
import { now } "mo:base/Time";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Random "mo:random/Rand";
import { print } "mo:base/Debug";
shared ({caller = DEPLOYER}) actor class() {

  type User = Types.User;
  type UserUpdatableData = Types.UserUpdatableData;
  type LoginResult = Types.LoginResult;
  type TaskDataInit = Types.TaskDataInit;
  type Task = Types.Task;
  type TaskPreview = Types.TaskPreview;

  stable let users = Map.new<Principal, User>();
  let verificationCodes = Map.new<Principal, Nat>();
  stable let notifications = Map.new<Principal, [Types.Notification]>();
  stable let msgs = Map.new<Principal, [Types.Msg]>();
  stable let activeTasks = Map.new<Nat, Types.Task>();
  stable let archivedTasks = Map.new<Nat, Types.Task>();
  stable let certificates = Map.new<Principal, [Types.Certificate]>();
  stable var admins: [Principal] = [DEPLOYER];

  let rand = Random.Rand();

  ////////////////// Admin funciotns ///////////////////

  public shared ({ caller }) func addAdmin(p: Principal): async {#Ok; #Err} {
    assert(isAdmin(caller));
    if (not isAdmin(p)){
      admins := Array.tabulate<Principal>(
        admins.size() + 1,
        func a = if(a < admins.size()) {admins[a]} else {p}
      );
      return #Ok
    };
    #Err
  };

  func isAdmin(p: Principal): Bool {
    for(a in admins.vals()){
      if (a == p ) return true;
    };
    return false
  };


  stable var lastTaskId = 0;
  stable var lastCertificateId = 0;

  public shared ({ caller }) func signUp({ name : Text }) : async LoginResult {
    if (Principal.isAnonymous(caller)) {
      return #Err("Caller anonymous");
    };
    switch (Map.get<Principal, User>(users, phash, caller)) {
      case null {
        let newUser = { Types.DefaultUser() with name; principal = caller };
        ignore Map.put<Principal, User>(users, phash, caller, newUser);
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
          certificates = getCertifiesByPrincipal(caller);
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
          certificates = getCertifiesByPrincipal(caller);
        });
      };
    };
  };

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
    let currentCertificates = getCertifiesByPrincipal(caller);
    let updateCertificates = Array.tabulate<Types.Certificate>(
      currentCertificates.size() + 1,
      func x = if (x < currentCertificates.size()) { currentCertificates[x] } else { newCertificate }
    );
    ignore Map.put<Principal, [Types.Certificate]>(certificates, phash, user, updateCertificates);
  };

  func getCertifiesByPrincipal(p: Principal):  [Types.Certificate]{
    switch(Map.get<Principal, [Types.Certificate]>(certificates, phash, p)){
      case null [];
      case (?c) {c}
    }
  };

  public shared ({ caller }) func loadAvatar(avatar: Blob, thumbnail: Blob): async {#Ok; #Err: Text}{
    let user = switch (Map.get<Principal, User>(users, phash, caller)) {
      case null { return #Err("User not found") };
      case (?user) { user };
    };
    ignore Map.put<Principal, User>(users, phash, caller, {user with avatar = ?avatar; thumbnail = ?thumbnail});
    #Ok
  };

  public shared ({ caller }) func editProfile(data : UserUpdatableData) : async {
    #Ok : User;
    #Err : Text;
  } {
    let user = switch (Map.get<Principal, User>(users, phash, caller)) {
      case null { return #Err("User not found") };
      case (?user) { user };
    };
    let { name; email } = data;
    let verified = (user.email == email) and (email != null); // En caso de que el usuario modifique su email tendrá que verificarlo nuevamente
    let updatedUser = {
      user with
      verified;
      name = switch (name) { case null user.name; case (?n) n };
      email = switch (email) { case null user.email; case e e };
    };
    ignore Map.put<Principal, User>(users, phash, caller, updatedUser);
    #Ok(updatedUser);
  };

  public shared ({ caller }) func getVerificationCode(): async ?Nat {
    switch (Map.get<Principal, User>(users, phash, caller)){ 
      case null {return null};
      case ( _ ) {
        rand.setRange(100000, 999999);
        let code = await rand.next();
        ignore Map.put<Principal, Nat>(verificationCodes, phash, caller, code);
        ?code;
      }
    }
  };

  public shared ({ caller }) func enterCodeVerification(code: Nat): async Bool {
    switch (Map.get<Principal, User>(users, phash, caller)){
      case null false;
      case (?user) {
        if(verifyCode(caller, code)) {
          ignore Map.put<Principal, User>(users, phash, caller, { user with verified = true });
          true
        } else {
          false
        }
      }
    }
  };

  public shared query func getUser(u: Principal): async ?(User and {certificates: [Types.Certificate]}) {
    switch (Map.get<Principal, User>(users, phash, u)){
      case null null;
      case ( ?user ){
        ? {user with certificates = getCertifiesByPrincipal(u)}
      }
    }
  };

  ///////////////// Crud Tareas //////////////////

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
    let { description; keywords; rewardRange; title; assets} = data;

    lastTaskId += 1;

    let newTask: Task = {
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
        func(i) { if (i == user.tasks.size()) { lastTaskId } else { user.tasks[i] } }
      )
    };
    ignore Map.put<Principal, User>( users, phash, caller, updatedUser);
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
    author: User; 
    bidsDetails: [(Principal, Types.Offer)]
  };

  public shared query ({caller}) func expandTask(id : Nat) : async ?TaskExpandResponse {
    switch (Map.get<Nat, Task>(activeTasks, nhash, id)) {
      case null null;
      case ( ?task ) {
        let user = switch (Map.get<Principal, User>(users, phash, task.owner)){
          case null {return null};
          case (?user) user;
        };
        let bidsCounter = Map.size(task.bids);
        let bidsDetails = if(caller == task.owner){print("Hola");Map.toArray(task.bids)} else { print("Chau");[] };
        print("caller: " # debug_show(caller));
        print("owner Task: " # debug_show(task.owner));
        return ?{task = {task with bidsCounter};  author = user; bidsDetails};
      }
    };
  };

  public shared ({ caller }) func updateTask({id : Nat; data: Types.UpdatableDataTask}) : async { #Ok; #Err: Text } {
    let task = Map.get<Nat, Task>(activeTasks, nhash, id);
    let {title; description; rewardRange} = data;
    switch task {
      case null { return #Err("Task Id not found") };
      case (?task) {
        if (task.owner != caller or task.assignedTo != null) {
          return #Err("Caller is not owner");
        };
        if (Map.size(task.bids) > 0){
          return #Err("Task with pending bids cannot be updated");
        };
        let updatedTask: Task = {
          task with
          title;
          description;
          rewardRange
        };
        ignore Map.put<Nat, Task>(activeTasks, nhash, id, updatedTask);
        return #Ok;
      };
    };
  };

  public shared ({ caller }) func deleteTask(id: Nat): async {#Ok; #Err} {
    let task = Map.remove<Nat, Task>(activeTasks, nhash, id);
    switch task {
      case null { return #Err };
      case ( ?t ) {
        if (t.owner != caller or t.assignedTo != null) {
          ignore Map.put<Nat, Task>( activeTasks,  nhash,  id, t );
          #Err 
        } else {
          ignore Map.put<Nat, Task>( archivedTasks,  nhash,  id, t );
          #Ok;
        }
      }
    }
  };

  ////////////////////////////////////////////////////////////

  public shared ({ caller }) func applyForTask({taskId: Nat; amount: Nat}): async {#Ok; #Err: Text}{
    let user = switch(Map.get<Principal, User>(users, phash, caller)){
      case null { return #Err("Caller is not User") };
      case (?user) { user }; 
    };

    if(not user.verified) { return #Err("User is not verified") };

    let task: Task = switch (Map.get<Nat ,Task>(activeTasks, nhash, taskId)) {
      case null { return #Err("Task does not exist") };
      case (?task) { task };
    };

    if (caller == task.owner) { return #Err("Cannot apply for own task") };

    if (task.assignedTo != null) { 
      return #Err("Task is already assigned") 
    };

    if (amount < task.rewardRange.0 and task.rewardRange.1 < amount ){
      return #Err("Amount offer is out of range");
    };
    ignore Map.put<Principal, Types.Offer>(task.bids, phash, caller, {date = now(); amount });
    #Ok;
  };

  public shared query ({ caller }) func getBids(taskId: Nat): async [(Principal, Types.Offer)]{
    switch (Map.get<Nat, Task>(activeTasks, nhash, taskId)) {
      case null { return [] };
      case ( ?task ) {
        assert(caller == task.owner);
        Map.toArray<Principal, Types.Offer>(task.bids)
      }
    }
  };

  public shared ({ caller }) func acceptOffer(taskId: Nat, user: Principal): async { #Ok; #Err: Text } {

    let task: Task = switch (Map.get<Nat ,Task>(activeTasks, nhash, taskId)) {
      case null { return #Err("Task does not exist") };
      case (?task) { task };
    };

    if(task.owner != caller ){
      return #Err("Caller is not the task owner");
    };
    switch(task.assignedTo){
      case null {};
      case (_) { return #Err("Task is already assigned") };
    };

    let offerAccepted =  Map.get<Principal, Types.Offer>(task.bids, phash, user);
    switch offerAccepted {
      case null { 
        return #Err ("User has not made an offer") 
      };
      case ( ?offer ) {
        
        let updatedTask: Task = {
          task with
          status = #InProgress;
          assignedTo = ?user;
          finalAmount = ?(offer.amount);
          start = ?now();
        };
        ignore Map.put<Nat, Task>(activeTasks, nhash, taskId, updatedTask);
        return #Ok
      }
    } 
  };


  ///////////// private functions ///////////////

  // func isUser(p: Principal): Bool {
  //   Map.has<Principal, User>(users, phash, p)
  // };

  func verifyCode(u: Principal, _code: Nat): Bool {
    switch (Map.remove<Principal, Nat>(verificationCodes, phash, u)){
      case null false;
      case ( ?code ) {code == _code}
    }
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
