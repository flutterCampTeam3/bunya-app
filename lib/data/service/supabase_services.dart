import 'dart:io';
import 'package:bunya_app/data/model/offices_model.dart';
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

  String email = '';

  DBService() {
    getToken();
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
    print("in this func");
    final profileData = await supabase
        .from('Customer')
        .select()
        .eq('customerId', supabase.auth.currentUser!.id)
        .single();
    print(profileData.toString());
    if (profileData.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Future SignOut
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
    print("in the func");
    final response = await supabase
        .from('Customer')
        .select('*')
        .eq('customerId', supabase.auth.currentUser!.id)
        .single();
  }
// Get Office Profile
    Future getOffice() async {
      print("in the funjjjc");
      print("id${supabase.auth.currentUser!.id}");
      final response = await supabase
          .from('Offices')
          .select('*')
          .eq('officeId', supabase.auth.currentUser!.id)
          .single();
      print("after func $response");
      ProfileOfficeModel profileoffice = ProfileOfficeModel.fromJson(response);
      print("after func ${profileoffice.name}");
      print("after func ${profileoffice.email}");
      print("after func ${profileoffice.description}");
      print("after func ${profileoffice.phone}");

      return profileoffice;
    }

    Future editUpdate(
        {required String name,
        required String email,
        required int phone}) async {
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
    // .execute();

    if (response.isEmpty) {
      // Handle error
      print('Error: $response');
      return false;
    } else {
      return true;
    }
  }

    ///-- Delete Follower
  Future deleteFollowers({
    required String officeID,
  }) async {
    final response = await supabase
        .from('office_followers')
        .delete()
        .eq('officeId', officeID)
        .eq('customerId', supabase.auth.currentUser!.id);
    // .execute();
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
      print('in the func');

      final officeAccounte = await supabase
          .from('Offices')
          .select("*")
          .match({'departmentId': type});
      print('the length${officeAccounte.length}');
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

    Future<void> uploadImage(File imageFile) async {
      print("object");
      final response =
          await supabase.storage.from('ImageProfile').upload('kk', imageFile);
      print("oooooo");
     await UrlImage();
      print("done");
    }

    Future<void> UrlImage() async {
      final response = supabase.storage.from('ImageProfile').getPublicUrl("kk");
      print(response);
    }
  }

