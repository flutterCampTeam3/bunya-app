import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBlocCustomer extends Bloc<SignUpCustomerEvent, SignUpCustomerState> {
  SignUpBlocCustomer() : super(SignUpInitial()) {
    on<CreateAccountCustomerEvent>(createAccount);
  }

  Future<void> createAccount(CreateAccountCustomerEvent event, Emitter<SignUpCustomerState> emit) async {
    emit(LoadingSignUpCustomerState());

    if (event.name.trim().isNotEmpty &&
        event.email.trim().isNotEmpty &&
        event.password.trim().isNotEmpty &&
        event.phone.trim().isNotEmpty &&


        event.confirmPass.trim().isNotEmpty &&
        event.isChecked
        ) {
      try {
        emit(LoadingSignUpCustomerState());
        emit(SuccessSignUpCustomerState(msg: "تم إنشاء الحساب بنجاح"));
      } catch (error) {
        emit(ErrorSignUpCustomerState(msg: "هناك خطأ في إنشاء الحساب"));
      }
    } else {
      emit(ErrorSignUpCustomerState(msg: "الرجاء إدخال جميع القيم"));
    }
  }
}


