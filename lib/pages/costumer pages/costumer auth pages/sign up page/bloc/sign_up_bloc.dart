import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBlocCustomer
    extends Bloc<SignUpCustomerEvent, SignUpCustomerState> {
  SignUpBlocCustomer() : super(SignUpInitial()) {
    on<CreateAccountCustomerEvent>(createAccount);
    on<CustomerChoosImageEvent>((event, emit) async {
      File avatar = await pickedImage();
      emit(CustomerChoosImageEventShowImageState(avatar));
    });
  }

  Future pickedImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);

    return (img!.path);
  }

  Future<void> createAccount(CreateAccountCustomerEvent event,
      Emitter<SignUpCustomerState> emit) async {
    if (event.name.trim().isNotEmpty &&
        event.email.trim().isNotEmpty &&
        event.password.trim().isNotEmpty &&
        event.phone.trim().isNotEmpty &&
        event.confirmPass.trim().isNotEmpty &&
        event.isChecked) {
      try {
        emit(LoadingSignUpCustomerState());
        await DBService().signUpC(
            phoneNumber: event.phone,
            userName: event.name,
            email: event.email,
            password: event.password);
        emit(SuccessSignUpCustomerState(msg: "تم إنشاء الحساب بنجاح"));
      } catch (error) {
        emit(ErrorSignUpCustomerState(msg: "هناك خطأ في إنشاء الحساب"));
      }
    } else {
      emit(ErrorSignUpCustomerState(msg: "الرجاء إدخال جميع القيم"));
    }
  }
}
