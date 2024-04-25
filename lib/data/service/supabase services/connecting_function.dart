part of 'services.dart';


extension ConnectedUserServices on DBService {

  Future signIn({required String email, required String password}) async {
     await supabase.auth
        .signInWithPassword(email: email, password: password);
    token = supabase.auth.currentSession!.accessToken;
    id = supabase.auth.currentSession!.user.id;
    addToken();
  }

  Future checkUserCustomer() async {
    final profileData = await supabase
        .from('Customer')
        .select()
        .eq('customerId', supabase.auth.currentUser!.id);
    if (profileData.isNotEmpty) {
      userType = true;
      return true;
    } else {
      userType = false;
      return false;
    }
  }

  Future signOut() async {
    await supabase.auth.signOut();
  }

  Future sendOtp({
    required String email,
  }) async {
    await supabase.auth.signInWithOtp(
      email: email,
    );
  }

  Future verifyOtp({required String email, required String otpToken}) async {
    await supabase.auth
        .verifyOTP(token: otpToken, type: OtpType.email, email: email);
  }

  Future resendOtp({required String email}) async {
    sendOtp(email: email);
  }

  Future resetPassword({required String newPassword}) async {
    await supabase.auth.updateUser(UserAttributes(password: newPassword));
  }

  // ------ Users data Services -----

    // Get Current session info
  Future<Session?> getCurrentSession() async {
    final session = supabase.auth.currentSession;
    return session;
  }

  // Get Current User Id
  String getCurrentUser() {
    final currentUser = supabase.auth.currentSession!.user.id;
    id = currentUser;
    return id;
  }


    ///-- add Follower
  Future addFollowers({
    required String officeID,
  }) async {
    await supabase.from('office_followers').insert(
      {
        'officeId': officeID,
        'customerId': supabase.auth.currentUser!.id,
      },
    );
    final response = await supabase
        .from('office_followers')
        .select()
        .eq('officeId', officeID)
        .eq('customerId', supabase.auth.currentUser!.id);
    if (response.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  ///-- Check Follower
  Future<bool> checkFollowers({
    required String officeID,
  }) async {
    final response = await supabase
        .from('office_followers')
        .select()
        .eq('officeId', officeID)
        .eq('customerId', supabase.auth.currentUser!.id);
    if (response.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  ///-- Delete Follower
  Future deleteFollowers({
    required String officeID,
  }) async {
    await supabase
        .from('office_followers')
        .delete()
        .eq('officeId', officeID)
        .eq('customerId', supabase.auth.currentUser!.id);

    final response = await supabase
        .from('office_followers')
        .select()
        .eq('officeId', officeID)
        .eq('customerId', supabase.auth.currentUser!.id);
    if (response.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  ///-- Check Like
  Future<bool> checkLike({
    required String postId,
  }) async {
    final response = await supabase
        .from('post_likes')
        .select()
        .eq('postId', postId)
        .eq('customerId', supabase.auth.currentUser!.id);
    if (response.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  ///-- add Like
  Future addLike({
    required postModel post,
  }) async {
    await supabase.from('post_likes').insert(
      {
        'postId': post.postId,
        'postOfficeId': post.ofiiceId,
        'customerId': supabase.auth.currentUser!.id,
      },
    );
    final response = await supabase
        .from('post_likes')
        .select()
        .eq('postId', post.postId)
        .eq('customerId', supabase.auth.currentUser!.id);
    if (response.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  ///-- Delete Like
  Future deleteLike({
    required String postId,
  }) async {
    await supabase
        .from('post_likes')
        .delete()
        .eq('postId', postId)
        .eq('customerId', supabase.auth.currentUser!.id);

    final response = await supabase
        .from('post_likes')
        .select()
        .eq('postId', postId)
        .eq('customerId', supabase.auth.currentUser!.id);
    if (response.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  // post like number
  Future getLikeNumber({
    required String postId,
  }) async {
    final postLikeNumber =
        await supabase.from('post_likes').select('*').eq('postId', postId);
    if (postLikeNumber.isNotEmpty) {
      final List<postLikeModel> likes = [];
      for (var element in postLikeNumber) {
        likes.add(postLikeModel.fromJson(element));
      }
      return likes.length;
    } else {
      return 0;
    }
  }

    // post Office like number
  Future getOfficeLikeNumber({
    required String officeId,
  }) async {
    final postLikeNumber = await supabase
        .from('post_likes')
        .select('*')
        .eq('postOfficeId', officeId);
    if (postLikeNumber.isNotEmpty) {
      final List<postLikeModel> likes = [];
      for (var element in postLikeNumber) {
        likes.add(postLikeModel.fromJson(element));
      }
      return likes.length;
    } else {
      return 0;
    }
  }

    // Office follower number
  Future followerNumber({
    required String officeId,
  }) async {
    final followerNumber = await supabase
        .from('office_followers')
        .select('*')
        .eq('officeId', officeId);

    if (followerNumber.isNotEmpty) {
      final List<ProfileOfficeFollowModel> follower = [];
      for (var element in followerNumber) {
        follower.add(ProfileOfficeFollowModel.fromJson(element));
      }
      return follower.length;
    } else {
      return 0;
    }
  }

    // Office following number
    Future followingNumber({
    required String customerId,
  }) async {
    final followerNumber = await supabase
        .from('office_followers')
        .select('*')
        .eq('customerId', customerId);
    if (followerNumber.isNotEmpty) {
      final List<ProfileOfficeFollowModel> follower = [];
      for (var element in followerNumber) {
        follower.add(ProfileOfficeFollowModel.fromJson(element));
      }
      return follower.length;
    } else {
      return 0;
    }
  }

    // Get posts
    Future<List<postModel>> getposts() async {
    final postData = await supabase.from('post').select('*');
    final List<postModel> classposts = [];
    for (var element in postData) {
      classposts.add(postModel.fromJson(element));
    }
    return classposts;
  }

    // Get Office posts
  Future<List<postModel>> getPostsId({required String ofiiceId}) async {
    final postData =
        await supabase.from('post').select('*').match({'ofiiceId': ofiiceId});
    final List<postModel> classposts = [];
    for (var element in postData) {
      classposts.add(postModel.fromJson(element));
    }
    return classposts;
  }
    // Get Offices of the department
  Future<List<OfficesModel>> getOfficeAccount(String type) async {
    final officeAccounte = await supabase
        .from('Offices')
        .select("*")
        .match({'departmentId': type});
    final List<OfficesModel> officeAccount = [];
    for (var element in officeAccounte) {
      officeAccount.add(OfficesModel.fromJson(element));
    }
    return officeAccount;
  }

    // Get Search Offices of the department
  Future<List<OfficesModel>> getSearchOfficeAccount(String name) async {
    final officeAccountsResponse =
        await supabase.from('Offices').select("*").eq('name', name);
    final List<OfficesModel> SearchofficeAccounts = [];
    for (var element in officeAccountsResponse) {
      SearchofficeAccounts.add(OfficesModel.fromJson(element));
    }
    return SearchofficeAccounts;
  }

    // Get Offices 
  Future<List<OfficesModel>> getOffices() async {
    final officesData = await supabase.from('Offices').select('*');
    final List<OfficesModel> classOffices = [];
    for (var element in officesData) {
      classOffices.add(OfficesModel.fromJson(element));
    }
    return classOffices;
  }

  //-------------------- uplaod post image
  Future<void> uploadImage(
      File imageFile, String bucket, String nameFile) async {
    await supabase.storage
        .from(bucket) // Replace with your storage bucket name
        .upload(nameFile, imageFile,
            fileOptions: const FileOptions(upsert: true));
    await urlImage(bucket, nameFile);
    print("done");
  }

  Future<void> uploadProfileImage(
      File imageFile, String bucket, String nameFile) async {
    await supabase.storage.from(bucket).upload(nameFile, imageFile,
        fileOptions: const FileOptions(upsert: true));
    await urlImage(bucket, nameFile);
    print("done");
  }

  Future<void> updateImage(
      File imageFile, String bucket, String nameFile) async {
    await supabase.storage
        .from(bucket) // Replace with your storage bucket name
        .update(nameFile, imageFile);
    await urlImage(bucket, nameFile);
    print("done add");
  }

  Future<void> deleteImage(String bucket, String nameFile) async {
    await supabase.storage
        .from(bucket) // Replace with your storage bucket name
        .remove([nameFile]);
    print("done remove");
  }

  Future<String> urlImage(String bucket, String nameFile) async {
    final response = supabase.storage
        .from(bucket) // Replace with your storage bucket name
        .getPublicUrl(nameFile);
    return response;
  }

  Future<String> UrlImage(String id) async {
    final response = supabase.storage.from('profile').getPublicUrl(id);

    return response;
  }
  //-------------------- 

    // Add Problem Massage
    Future addProblemMassage({
    required String massage,
  }) async {
    await supabase.from('Problem').insert(
      {
        'iduser': supabase.auth.currentUser!.id,
        'massage': massage,
      },
    );
  }


   getSession() async {
    try {
      final Session? session = await DBService().getCurrentSession();
      if (session != null) {
        id = getCurrentUser();
        await checkUserCustomer();
        isSession = true;
        return true;
      } else {
        isSession = false;
        return false;
      }
    } catch (e) {
      isSession = false;
      return false;
    }
  }

//--------------------------------//--------------------------------//--------------------------------
  // -- Getting current user ID --
  Future getCurrentUserID() async {
    final currentUserId = supabase.auth.currentUser?.id;
    return currentUserId;
  }

  // -- Submit message --
  Future submitMessage(String msgContent, Room room) async {
    final currentUserId = await getCurrentUserID();
    await supabase.from("messages").insert({
      'profile_id': currentUserId,
      'content': msgContent,
      'room_id': room.id
    });
  }

  // -- Get messages stream --
  Future getMessagesStream(int roomId) async {
    final userID = await getCurrentUserID();
    print(roomId);
    final Stream<List<Message>> msgStream = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq("room_id", roomId) // عشان يجيب بس حق هذا التيبل
        .order('created_at')
        .map((massages) => massages
            .map((message) => Message.fromJson(json: message))
            .toList());

    listOfMessages = msgStream;
  }

  // --- Get Profile data by profile ID of a specific message ---
  Future getProfileData(String customerId) async {
    print(customerId);

    final data =
        await supabase.from('Customer').select().eq('customerId', customerId);
    // .single();

    final profile = data.isNotEmpty ? ProfileModel.fromJson(data.first) : null;
    return profile;
  }

  Future createRoom(String officeId) async {
    final currentUserId = await getCurrentUserID();
    print("create");
    final response = await supabase
        .from("room")
        .insert({"customer_id": currentUserId, "offecer_id": officeId});
  }

  Future checkRoom(String officeId) async {
    final currentUserId = await getCurrentUserID();
    final response = await supabase
        .from('room')
        .select()
        .eq('offecer_id', officeId)
        .eq('customer_id', currentUserId);
    print(response);
    if (response.isEmpty) {
      await createRoom(officeId);
      final response = await supabase
          .from('room')
          .select()
          .eq('offecer_id', officeId)
          .eq('customer_id', currentUserId);
      return Room.fromJson(json: response.first);
    } else {
      return Room.fromJson(json: response.first);
    }
  }

  Future fetchRooms() async {
    final currentUserId = await getCurrentUserID();

    final data = await supabase
        .from('room')
        .select()
        .or('customer_id.eq.$currentUserId, offecer_id.eq.$currentUserId');
    //حجيب كل الرومات اللي اكون فيها كستمر او اوفيس

    final listRooms = data.map((room) => Room.fromJson(json: room)).toList();
    return listRooms;
  }

  Future fetchPersonRoom(List<Room> roomsList) async {
    final currentUserId = await getCurrentUserID();
    List<ChatProfileModel> chatProfileList = [];
    print(roomsList.length);
    for (Room room in roomsList) {
      print("in loop");
      if (room.customer_id != currentUserId &&
          room.offecer_id == currentUserId) {
        final resCustomer = await supabase
            .from("Customer")
            .select("*")
            .eq("customerId", room.customer_id);
        final resOffices = await supabase
            .from("Offices")
            .select("*")
            .eq("officeId", room.customer_id);
        if (resCustomer.isNotEmpty) {
          //حيكون المستخدم الثاني ويضيف في اللست الي فووق
          chatProfileList
              .add(ChatProfileModel.fromJson(resCustomer.first, room));
        }
        if (resOffices.isNotEmpty) {
          //حيكون اوفيس ويضيف
          chatProfileList
              .add(ChatProfileModel.fromJson(resOffices.first, room));
        }
        //كل هذا عشان عندنا جدولين
      } else if (room.offecer_id != currentUserId &&
          room.customer_id == currentUserId) {
        final resCustomer = await supabase
            .from("Customer")
            .select("*")
            .eq("customerId", room.offecer_id);
        final resOffices = await supabase
            .from("Offices")
            .select("*")
            .eq("officeId", room.offecer_id);
        if (resCustomer.isNotEmpty) {
          chatProfileList
              .add(ChatProfileModel.fromJson(resCustomer.first, room));
        }
        if (resOffices.isNotEmpty) {
          chatProfileList
              .add(ChatProfileModel.fromJson(resOffices.first, room));
        }
      }
    }
    print(chatProfileList);
    return chatProfileList;
  }

}

