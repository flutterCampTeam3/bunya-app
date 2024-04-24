import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/service/check_office_api.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  bool checkOffice = false;
  String type = 'التصميم الداخلي';
  final locator = GetIt.I.get<DBService>();
  SignUpBloc() : super(SignUpInitial()) {
    on<CreateAccountEvent>(createAccount);
    on<CreateAccountprofileEvent>(createProfileAccount);
    on<ChoosImageEvent>((event, emit) async {
      File avatar = await pickedImage();
      locator.OfficeImageFile = avatar;
      emit(ShowImageOfficeState(avatar));
    });
     on<UploadProfileOfficeImage>((event, emit) async {
      locator.uploadProfileImage(
          locator.coustomerImageFile, event.bucketName, event.fileName);

      locator.imageId = await locator.UrlImage(event.fileName);
    });
  }

  Future pickedImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);

    return (img!.path);
  }

  Future<void> createAccount(
      CreateAccountEvent event, Emitter<SignUpState> emit) async {
    emit(LoadingSignUpState());

    if (event.name.trim().isNotEmpty &&
            event.email.trim().isNotEmpty &&
            event.password.trim().isNotEmpty &&
            // event.id.trim().isNotEmpty &&
            event.cr.trim().isNotEmpty &&
            event.confirmPass.trim().isNotEmpty 
        ) {
      try {
        checkOffice = await CheckOffice().checkOffice(event.cr);
        print("the value $checkOffice");
        if (checkOffice) {
          emit(SuccessFindState(msg: 'السجل التجاري صحيح'));
        } else {
          emit(ErrorSignUpState(msg: 'لم يتم ايجاد السجل التجاري'));
        }
      } catch (error) {
        emit(ErrorSignUpState(msg: 'لم يتم ايجاد السجل التجاري'));
      }
    } else {
      emit(ErrorSignUpState(msg: "الرجاء إدخال جميع القيم"));
    }
  }

  FutureOr<void> createProfileAccount(
      CreateAccountprofileEvent event, Emitter<SignUpState> emit) async {
    emit(LoadingSignUpState());

            final locator = GetIt.I.get<DBService>();
    locator.uploadProfileImage(
        locator.coustomerImageFile, event.bucketName, event.fileName);
    String imageUrl = await locator.UrlImage(event.fileName);

    print("----> url $imageUrl");

    print("-------------------------------1");
    if (!event.name.trim().isNotEmpty &&
        !event.email.trim().isNotEmpty &&
        !event.cr.trim().isNotEmpty &&
        !event.info.trim().isNotEmpty &&
        !event.location.trim().isNotEmpty &&
        !event.phone.trim().isNotEmpty&&
        !imageUrl.isNotEmpty) {
      emit(ErrorSignUpState(msg: "الرجاء إدخال جميع القيم"));
    } else {
      try {
      print("in the bloc");
      try {
        print("-------------------------------2");
        print("in try ");
        print("in the if condition");
        final supabase = Supabase.instance.client;
        await supabase.auth.signUp(
          email: event.email,
          password: event.password,
        );
      } catch (error) {
        emit(ErrorSignUpState(msg: "هناك خطأ في إنشاء الحساب"));
      }
      await DBService().createProfileOffice(
        userName: event.name,
        email: event.email,
        cr: event.cr,
        departmentId: event.departmentId,
        disc: event.info,
        phoneNumber: event.phone,
        image: imageUrl,
      );
      emit(SuccessSignUpState(msg: "تم إنشاء الحساب بنجاح"));
      } catch (error) {
        emit(ErrorSignUpState(msg: "هناك خطأ في إنشاء الحساب"));
      }
    }
  }
}
