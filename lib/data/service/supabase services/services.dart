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
import '../../model/post_model.dart';
part 'connecting_function.dart';
part 'customer_function.dart';
part 'office_function.dart';

class DBService {
  final supabase = Supabase.instance.client;

  // Fetched Messages

  late Stream<List<Message>> listOfMessages;

  // ------ Data Storage -----

  final box = GetStorage();

  String token = '';

  String id = '';

  String name = '';

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

  // Future<String> urlImageSignUp() async {
  //   final response = supabase.storage
  //       .from('profile')
  //       .getPublicUrl(supabase.auth.currentUser!.id);

  //   return response;
  // }

  //-----------------------------------------------
  //-----------------------------------------------
}