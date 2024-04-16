import 'package:bunya_app/data/model/medicattion_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    required String departmentId,
    required String cr,
    // required String image,
  }) async {
    print(" before: ");
    final respons = await supabase.auth.signUp(
      data: {'Name': userName},
      email: email,
      password: password,
    );
    print("${respons.hashCode}");
    if (respons.hashCode >= 200 && respons.hashCode <= 299) {
      await supabase.from('Offices').insert(
        {
          'departmentId': departmentId,
          'name': userName,
          'officeId': respons.user!.id,
          'cr': cr,
          // 'image': image,
        },
      );
    }
    print("in the signup: ${respons.hashCode}");
    // Send email verification
    // await supabase.auth.resetPasswordForEmail(email);
  }

  //---costumer SignUp func
  Future signUpC({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
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
      },
    );

    print("in the signup: ${respons.hashCode}");
    // Send email verification
    // await supabase.auth.resetPasswordForEmail(email);
  }

  Future signIn({required String email, required String password}) async {
    print('in the func');
    final state = await supabase.auth
        .signInWithPassword(email: email, password: password);
    if (state.hashCode >= 200 && state.hashCode <= 299) {
      print('after the func');
      token = supabase.auth.currentSession!.accessToken;
      id = supabase.auth.currentSession!.user.id;
      addToken();
    } else {
      throw const AuthException('الايميل او الرقم السري خطا');
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

  Future verifyOtp({required String otpToken, required String email}) async {
    await supabase.auth
        .verifyOTP(email: email, token: token, type: OtpType.magiclink);
  }

  Future resetPassword({required String password}) async {
    await supabase.auth.updateUser(UserAttributes(password: password));
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

  ///-- add user name
  Future addUserName({
    required String name,
    required String id,
  }) async {
    await supabase.from('users').insert(
      {
        "name": name,
        "id": id,
      },
    );
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
}
