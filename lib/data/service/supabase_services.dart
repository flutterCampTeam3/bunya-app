import 'dart:io';
import 'package:bunya_app/data/model/office_follow_model.dart';
import 'package:bunya_app/data/model/offices_model.dart';
import 'package:bunya_app/data/model/post_like_model.dart';
import 'package:bunya_app/data/model/profile_model_customer.dart';
import 'package:bunya_app/data/model/profile_model_office.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/post_model.dart';

class DBService {
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

  File coustomerImageFile = File("");

  File OfficeImageFile = File("");

  File PostImageFile = File("");

  String imageId = "";

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
    // await supabase.auth.resetPasswordForEmail(email);
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
        'phoneNumber': int.parse(phoneNumber),
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
    final respons = await supabase.auth.signUp(
      data: {'Name': userName},
      email: email,
      password: password,
    );
    await supabase.from('Customer').insert(
      {
        'email': email,
        'name': userName,
        'phoneNumber': int.parse(phoneNumber),
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
  Future<String> getCurrentUser() async {
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
      required int phone,
      required String description}) async {
    await supabase.from('Offices').update(
      {
        'name': name,
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

  Future getOfficeLikeOfficeNumber() async {
    final postLikeNumber = await supabase
        .from('post_likes')
        .select('*')
        .eq('postOfficeId', supabase.auth.currentUser!.id);
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
     print("---------------in function----");
    final followerNumber = await supabase

        .from('office_followers')
        .select('*')
        .eq('officeId', officeId);
         print("---------------inside f..----");
    if (followerNumber.isNotEmpty) {
      final List<ProfileOfficeFollowModel> follower = [];
      for (var element in followerNumber) {
        follower.add(ProfileOfficeFollowModel.fromJson(element));
      }
       print("---------------${follower.length}----");
      return follower.length;
    } else {
       print("---------------Else ----");
      return 0;
    }
  }

  Future getFollowers() async {
    print("in the Function -------------------------------------------------");
    final followerNumber = await supabase
        .from('office_followers')
        .select('*')
        .eq('customerId', supabase.auth.currentUser!.id);
    print(
        "in the $followerNumber -------------------------------------------------");

    if (followerNumber.isNotEmpty) {
      print("Hhhhh -------------------------------------------------");

      final List<ProfileOfficeFollowModel> follower = [];
      for (var element in followerNumber) {
        follower.add(ProfileOfficeFollowModel.fromJson(element));
      }
      print(
          "BBBB ------${follower.length}-------------------------------------------");

      final List<OfficesModel> followers = [];
      for (var element in follower) {
        final follow = await supabase
            .from('Offices')
            .select('*')
            .eq('officeId', element.officeId);
        print("BBBB ------$follow-------------------------------------------");

        for (var element in follow) {
          followers.add(OfficesModel.fromJson(element));
        }
        print(
            "BBBB ------${follower.length}-------------------------------------------");
      }
      return followers;
    } else {
             final List<OfficesModel> followers = [];

      return  followers;
    }
  }

  Future followerOfficeNumber() async {
    final followerNumber = await supabase
        .from('office_followers')
        .select('*')
        .eq('officeId', supabase.auth.currentUser!.id);
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

  Future followingOfficeNumber() async {
    final followerNumber = await supabase
        .from('office_followers')
        .select('*')
        .eq('customerId', supabase.auth.currentUser!.id);
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

  Future<List<postModel>> getPostsOffficeId() async {
    final postData = await supabase
        .from('post')
        .select('*')
        .match({'ofiiceId': supabase.auth.currentUser!.id});
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
         print("-----------------in func-------");
    final List<OfficesModel> officeAccount = [];
    for (var element in officeAccounte) {
      officeAccount.add(OfficesModel.fromJson(element));
    }
     print("------------------------");
    return officeAccount;
  }

  Future<List<OfficesModel>> getSearchOfficeAccount(String name) async {
    final officeAccountsResponse =
        await supabase.from('Offices').select("*").eq('name', name);

    final List<OfficesModel> SearchofficeAccounts = [];
    for (var element in officeAccountsResponse) {
      SearchofficeAccounts.add(OfficesModel.fromJson(element));
    }
    return SearchofficeAccounts;
  }

  Future<List<OfficesModel>> getOffices() async {
    final officesData = await supabase.from('Offices').select('*');
    final List<OfficesModel> classOffices = [];
    for (var element in officesData) {
      classOffices.add(OfficesModel.fromJson(element));
    }
    return classOffices;
  }

  //-------------------- uplaod post image

  //-------------------------------
  //-------------------------------
  Future<void> uploadImage(
      File imageFile, String bucket, String nameFile) async {
    await supabase.storage
        .from(bucket) // Replace with your storage bucket name
        .upload(nameFile, imageFile,
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

  //-----------------------------------------------
  //-----------------------------------------------

  Future addPost({
    required String desc,
  }) async {
    await supabase.from('post').insert(
      {
        'ofiiceId': supabase.auth.currentUser!.id,
        'desc': desc,
        'image': imageId
      },
    );
  }
/*
  Future<void> uploadPostImage(File imageFile) async {
    print("object");
    print('-------------------------------------');
    final response = await supabase.storage.from('profile').upload(
          'PostFolder/yess',
          imageFile,
        );
    print("Post");
    UrlImage();
    print("done");
  }
  //-------------- uplaod imgae profile

  Future<void> uploadCustomerImage(File imageFile) async {
    print("object");
    //supabase.storage.setAuth("jwt");
    final response = await supabase.storage.from('profile').upload(
          'CustomerProfileFolder/k1',
          imageFile,
        );
    print("Customer");
 //   UrlImage();
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
   // UrlImage();
    print("done");
  }

  
  
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

  Future<String> UrlImage(String id) async {
    final response = supabase.storage.from('profile').getPublicUrl(id);
    print(response);

    return response;
  }

//-----------------
  getSession() async {
    try {
      final Session? session = await DBService().getCurrentSession();
      if (session != null) {
        id = await getCurrentUser();
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
}
