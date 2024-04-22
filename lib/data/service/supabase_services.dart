import 'dart:io';
import 'package:bunya_app/data/model/chat_profile_model.dart';
import 'package:bunya_app/data/model/messege_model.dart';
import 'package:bunya_app/data/model/office_follow_model.dart';
import 'package:bunya_app/data/model/offices_model.dart';
import 'package:bunya_app/data/model/post_like_model.dart';
import 'package:bunya_app/data/model/profile_model_customer.dart';
import 'package:bunya_app/data/model/profile_model_office.dart';
import 'package:bunya_app/data/model/room_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/post_model.dart';

class DBService {
  late Stream<List<Message>> listOfMessages; // Fetched Messages

  // ------ Data Storage -----

  final box = GetStorage();
  String token = '';

  String id = '';

  String name = '';

  String officeName = '';

  bool userType = false;

  bool isSession = false;

  String email = '';

  String currentTheme = 'Light';

  DBService() {
    getToken();
    getTheme();
  }

  addToken() async {
    if (token.isNotEmpty) {
      await box.write("token", token);
    }
    box.save();
  }

  getToken() {
    if (box.hasData("token")) {
      if (token.isEmpty) {
        token = box.read("token");
      }
    }
  }

  void getTheme() {
    if (box.read('theme') == null) {
      box.write('theme', currentTheme);
    } else {
      currentTheme = box.read('theme');
    }
  }

  void changeTheme() {
    if (currentTheme == 'Dark') {
      box.write('theme', 'Light');
    } else {
      box.write('theme', 'Dark');
    }
  }

  final supabase = Supabase.instance.client;

//--- Office SignUp func
  Future signUpO({
    required String email,
    required String password,
    required String userName,
    // required String image,
  }) async {
    print(" before: in the func");
    final respons = await supabase.auth.signUp(
      data: {'Name': userName},
      email: email,
      password: password,
    );
    id = respons.user!.id;
    print("${respons.hashCode}");
    // Send email verification
    await supabase.auth.resetPasswordForEmail(email);
  }

  //--- Office SignUp func
  Future createProfileOffice({
    required String email,
    required String userName,
    required String departmentId,
    required String phoneNumber,
    required String cr,
    required String disc,
    // required String image,
  }) async {
    await supabase.from('Offices').insert(
      {
        'departmentId': departmentId,
        'name': userName,
        'officeId': supabase.auth.currentUser!.id,
        'cr': cr,
        'disc': disc,
        'phoneNumber': phoneNumber,
        'email': email,
        'image': 'nn',
      },
    );
  }

  //---costumer SignUp func
  Future signUpC({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
    required String image,
  }) async {
    print(" before: ");
    final respons = await supabase.auth.signUp(
      data: {'Name': userName},
      email: email,
      password: password,
    );
    print("iidone");
    await supabase.from('Customer').insert(
      {
        'email': email,
        'name': userName,
        'phoneNumber': phoneNumber,
        'customerId': respons.user!.id,
        'image':
            'https://mtaainvajktwbwpffkxw.supabase.co/storage/v1/object/public/profile/Ellipse%2024.svg'
      },
    );

    print("in the signup: ${respons.hashCode}");
    // Send email verification
    // await supabase.auth.resetPasswordForEmail(email);
  }

  Future signIn({required String email, required String password}) async {
    final state = await supabase.auth
        .signInWithPassword(email: email, password: password);
    token = supabase.auth.currentSession!.accessToken;
    id = supabase.auth.currentSession!.user.id;
    addToken();
  }

  Future checkUserCustomer() async {
    print("i------------");
    final profileData = await supabase
        .from('Customer')
        .select()
        .eq('customerId', supabase.auth.currentUser!.id);
    // .single();
    print("i-2-----------$profileData");
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

  // ------ User data Services -----

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

  Future getUser() async {
    final response = await supabase
        .from('Customer')
        .select('*')
        .eq('customerId', supabase.auth.currentUser!.id)
        .single();
    return ProfileModel.fromJson(response);
  }

// Get Office Profile
  Future getOffice() async {
    final response = await supabase
        .from('Offices')
        .select('*')
        .eq('officeId', supabase.auth.currentUser!.id)
        .single();
    ProfileOfficeModel profileoffice = ProfileOfficeModel.fromJson(response);

    return profileoffice;
  }

  Future editUpdate(
      {required String name, required String email, required int phone}) async {
    await supabase.from('Customer').update(
      {
        'name': name,
        'email': email,
        'phoneNumber': phone,
      },
    ).match({'customerId': supabase.auth.currentUser!.id});
  }

  // to edit office profile
  Future editUpdateOffice(
      {required String name,
      required String email,
      required int phone,
      required String description}) async {
    await supabase.from('Offices').update(
      {
        'name': name,
        'email': email,
        'disc': description,
        'phoneNumber': phone,
      },
    ).match({'officeId': supabase.auth.currentUser!.id});
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

  // post like number
  Future getOfficeLikeNumber({
    required String officeId,
  }) async {
    final postLikeNumber = await supabase
        .from('post_likes')
        .select('*')
        .eq('postOfficeId', officeId);
    print("in the getOfficeLikeNumber after");
    print("-------------------------------");
    print("-------------------------------${postLikeNumber.length}");
    if (postLikeNumber.isNotEmpty) {
      final List<postLikeModel> likes = [];
      for (var element in postLikeNumber) {
        likes.add(postLikeModel.fromJson(element));
      }
      print("-------------------------------the num${likes.length}");
      return likes.length;
    } else {
      print("-------------------------------the num  else 0");
      return 0;
    }
  }

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

  Future<List<postModel>> getposts() async {
    final postData = await supabase.from('post').select('*');
    final List<postModel> classposts = [];
    for (var element in postData) {
      classposts.add(postModel.fromJson(element));
    }
    return classposts;
  }

  Future<List<postModel>> getPostsId({required String ofiiceId}) async {
    final postData =
        await supabase.from('post').select('*').match({'ofiiceId': ofiiceId});
    final List<postModel> classposts = [];
    for (var element in postData) {
      classposts.add(postModel.fromJson(element));
    }
    return classposts;
  }

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

  Future<List<OfficesModel>> getOffices() async {
    final officesData = await supabase.from('Offices').select('*');
    final List<OfficesModel> classOffices = [];
    for (var element in officesData) {
      classOffices.add(OfficesModel.fromJson(element));
    }
    return classOffices;
  }

  //-------------------- uplaod image

  Future<void> uploadCustomerImage(File imageFile) async {
    print("object");
    //supabase.storage.setAuth("jwt");
    final response = await supabase.storage.from('profile').upload(
          'CustomerProfileFolder/k1',
          imageFile,
        );
    print("Customer");
    UrlImage();
    print("done");
  }
  //-------- uplaod office profile

  Future<void> uploadOfficeImage(File imageFile) async {
    print("object");

    final response = await supabase.storage.from('profile').upload(
          'OfficeProfileFolder/k2',
          imageFile,
        );
    print("Office");
    UrlImage();
    print("done");
  }

  Future<void> uploadPostImage(File imageFile) async {
    print("object");

    final response = await supabase.storage.from('profile').upload(
          'PostFolder/khlod',
          imageFile,
        );
    print("Post");
    UrlImage();
    print("done");
  }

  /*
  
  //--

Future<void> uploadImage(File imageFile, {String? name,String id}) async {
    print("object");

    final response = await supabase.storage.from('profile').upload(
          '$id/${name ?? "kk"}',
          imageFile,
        );
    print("oooooo");
    UrlImage();
    print("done");
  }
*/
  //--

  Future<void> UrlImage() async {
    final response = supabase.storage.from('profile').getPublicUrl("kk");
    print(response);
  }

//-----------------
  getSession() async {
    try {
      final Session? session = await DBService().getCurrentSession();
      if (session != null) {
        id = getCurrentUser();
        await checkUserCustomer();
        isSession = true;
        print("in the function of bool");
        print("-----------------------------2");
        print("$isSession");
        print("-----------------------------2");
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
  Future getProfileData(String profileID) async {
    final data =
        await supabase.from('profiles').select().eq('id', profileID).single();
    final profile = ProfileModel.fromJson(data);
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
////////////
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
