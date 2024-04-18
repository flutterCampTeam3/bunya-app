import 'package:bunya_app/data/model/medicattion_model.dart';
import 'package:bunya_app/data/model/offices_model.dart';
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
    print(" before: ");
    final respons = await supabase.auth.signUp(
      data: {'Name': userName},
      email: email,
      password: password,
    );
    id = respons.user!.id;
    print("${respons.hashCode}");
    print("in the signup: ${respons.hashCode}");
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
        'phoneNumber': phoneNumber,
        'email': email,
        // 'image': image,
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
    print("in the func");
    // signOut();
    final state = await supabase.auth
        .signInWithPassword(email: email, password: password);
    print("$state");
    token = supabase.auth.currentSession!.accessToken;
    id = supabase.auth.currentSession!.user.id;
    addToken();
  }

  Future checkUserCustomer() async {
    final profileData = await supabase
        .from('Customer')
        .select()
        .eq('customerId', supabase.auth.currentUser!.id)
        .single();

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
    await supabase.auth.resend(type: OtpType.magiclink, email: email);
  }

  Future resetPassword({required String newPassword}) async {
    await supabase.auth.updateUser(UserAttributes(password: newPassword));
  }

  // ------ Data Services -----

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

  // Get User Profile Data
  Future<Map<String, dynamic>> getUserProfile() async {
    final profileData = await supabase
        .from('users')
        .select()
        .eq('id', supabase.auth.currentUser!.id)
        .single();
    return profileData;
  }

  Future getUserName() async {
    final response = await supabase
        .from('users')
        .select('name')
        .eq('id', supabase.auth.currentUser!.id)
        .single();
    return await response['name'];
  }

  Future updateUserName({required String newName}) async {
    await supabase
        .from('users')
        .update({'name': newName}).eq('id', await getCurrentUser());
  }

  // ------ medication data Services -----

  // Get User Medications Data
  Future<List<MedicationModel>> getMedications() async {
    final medication =
        await supabase.from('medication').select('*').match({'userId': id});
    final List<MedicationModel> medications = [];
    for (var element in medication) {
      medications.add(MedicationModel.fromJson(element));
    }
    return medications;
  }

  ///-- add Follower
  Future addFollowers({
    required String userId,
    required String officeID,
  }) async {
    await supabase.from('office_followers').insert(
      {
        'officeId': officeID,
        'customerId': userId,
      },
    );
  }

  ///-- Check Follower
  Future<bool> checkFollowers({
    required String userId,
    required String officeID,
  }) async {
    final response = await supabase
        .from('office_followers')
        .select()
        .eq('officeId', officeID)
        .eq('customerId', userId);
    // .execute();

    if (response.isEmpty) {
      // Handle error
      print('Error: $response');
      return false;
    } else {
      return true;
    }
  }

  ///-- Check Follower
  Future deleteFollowers({
    required String userId,
    required String officeID,
  }) async {
     await supabase
        .from('office_followers')
        .delete()
        .eq('officeId', officeID)
        .eq('customerId', userId);
    // .execute();
  }

  // Add Medications to Data
  Future addMedications({
    required String name,
    required int pills,
    required int days,
    required String before,
    required String time,
  }) async {
    await supabase.from('medication').insert(
      {
        "medicationName": name,
        "pills": pills,
        "days": days,
        "userId": id,
        "before": before,
        "time": time,
        "isCompleted": false,
        "todayPills": false,
        "isUpdate": false,
        "updateTime": "",
        "UpdateTimeDate": "",
      },
    );
  }

  // Edit User Medications Data
  Future editMedications({
    required String name,
    required int pills,
    required int days,
    required String before,
    required MedicationModel medication,
    required String time,
  }) async {
    await supabase.from('medication').update(
      {
        "medicationName": name,
        "pills": pills,
        "days": days,
        "userId": id,
        "before": before,
        "time": time,
        "isCompleted": medication.isCompleted,
        "todayPills": medication.todayPills,
        "isUpdate": medication.isUpdate,
        "updateTime": medication.updateTime,
        "UpdateTimeDate": medication.updateTimeDate,
      },
    ).match({'medicationId': medication.medicationId});
  }

  // Edit User Medications Data
  Future editIsCompleted(
      {required MedicationModel medication, required bool isCompleted}) async {
    await supabase.from('medication').update(
      {
        "medicationName": medication.medicationName,
        "pills": medication.pills,
        "days": medication.days,
        "userId": medication.userId,
        "before": medication.before,
        "time": medication.time,
        "isCompleted": isCompleted,
        "todayPills": true,
        "isUpdate": false,
        "updateTime": medication.updateTime,
        "UpdateTimeDate": DateTime.now().toString(),
      },
    ).match({'medicationId': medication.medicationId});
  }

  Future editUpdate(
      {required MedicationModel medication,
      required bool isUpdate,
      required String updateTime,
      required String date}) async {
    await supabase.from('medication').update(
      {
        "medicationName": medication.medicationName,
        "pills": medication.pills,
        "days": medication.days,
        "userId": medication.userId,
        "before": medication.before,
        "time": medication.time,
        "isCompleted": medication.isCompleted,
        "todayPills": true,
        "isUpdate": isUpdate,
        "updateTime": updateTime,
        "UpdateTimeDate": date,
      },
    ).match({'medicationId': medication.medicationId});
  }

  Future editNotUpdate({
    required MedicationModel medication,
  }) async {
    await supabase.from('medication').update(
      {
        "medicationName": medication.medicationName,
        "pills": medication.pills,
        "days": medication.days,
        "userId": medication.userId,
        "before": medication.before,
        "time": medication.time,
        "isCompleted": medication.isCompleted,
        "todayPills": false,
        "isUpdate": medication.isUpdate,
        "updateTime": medication.updateTime,
        "UpdateTimeDate": medication.updateTimeDate,
      },
    ).match({'medicationId': medication.medicationId});
  }

  // Delete Medication
  Future deleteMedications({required midId}) async {
    await supabase.from('medication').delete().match({'medicationId': midId});
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
        await supabase.from('post').select('*').match({'ofiiceId':ofiiceId});
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
}
