import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/service/check_office_api.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  bool checkOffice = false;
  String type = 'التصميم الداخلي';
  SignUpBloc() : super(SignUpInitial()) {
    on<CreateAccountEvent>(createAccount);
    on<CreateAccountprofileEvent>(createProfileAccount);
    on<ChoosImageEvent>((event, emit) async {
      //------
      File avatar = await pickedImage();
      GetIt.I.get<DBService>().uploadOfficeImage(avatar);

      emit(ShowImageState(avatar));
      //------
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
        // && event.isChecked
        ) {
      try {
        emit(LoadingSignUpState());
       try {
        checkOffice = await CheckOffice().checkOffice(event.cr);
      } catch (error) {
        emit(ErrorSignUpState(msg: 'لم يتم ايجاد السجل التجاري'));
        }
        if (checkOffice) {
          DBService().signUpO(
              userName: event.name,
              email: event.email,
              password: event.password);
          emit(SuccessSignUpState(msg: "تم إنشاء الحساب بنجاح"));
        } else {
          emit(ErrorSignUpState(msg: 'لا يوجد سجل تجاري بهذا الرقم'));
        }
      } catch (error) {
        emit(ErrorSignUpState(msg: "هناك خطأ في إنشاء الحساب"));
      }
    } else {
      emit(ErrorSignUpState(msg: "الرجاء إدخال جميع القيم"));
    }
  }

  FutureOr<void> createProfileAccount(
      CreateAccountprofileEvent event, Emitter<SignUpState> emit) async {
    emit(LoadingSignUpState());

    if (event.name.trim().isNotEmpty &&
        event.email.trim().isNotEmpty &&
        event.cr.trim().isNotEmpty &&
        event.info.trim().isNotEmpty &&
        event.location.trim().isNotEmpty &&
        event.phone.trim().isNotEmpty) {
      try {
        try {
          if (checkOffice) {
            DBService().signUpO(
                userName: event.name,
                email: event.email,
                password: event.password);
            emit(SuccessSignUpState(msg: "تم إنشاء الحساب بنجاح"));
          } else {
            emit(ErrorSignUpState(msg: 'لا يوجد سجل تجاري بهذا الرقم'));
          }
        } catch (error) {
          emit(ErrorSignUpState(msg: "هناك خطأ في إنشاء الحساب"));
        }
        DBService().createProfileOffice(
            userName: event.name,
            email: event.email,
            cr: event.cr,
            departmentId: event.departmentId,
            disc: event.info,
            phoneNumber: event.phone);
        emit(SuccessSignUpState(msg: "تم إنشاء الحساب بنجاح"));
      } catch (error) {
        emit(ErrorSignUpState(msg: "هناك خطأ في إنشاء الحساب"));
      }
    } else {
      emit(ErrorSignUpState(msg: "الرجاء إدخال جميع القيم"));
    }
  }
}
