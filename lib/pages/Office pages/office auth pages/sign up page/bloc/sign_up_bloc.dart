import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<CreateAccountEvent>(createAccount);
  }

  Future<void> createAccount(CreateAccountEvent event, Emitter<SignUpState> emit) async {
    emit(LoadingSignUpState());

    if (event.name.trim().isNotEmpty &&
        event.email.trim().isNotEmpty &&
        event.password.trim().isNotEmpty &&
        event.id.trim().isNotEmpty &&
        event.cr.trim().isNotEmpty &&
        event.confirmPass.trim().isNotEmpty &&
        event.isChecked) {
      try {
        emit(LoadingSignUpState());
        emit(SuccessSignUpState(msg: "تم إنشاء الحساب بنجاح"));
      } catch (error) {
        emit(ErrorSignUpState(msg: "هناك خطأ في إنشاء الحساب"));
      }
    } else {
      emit(ErrorSignUpState(msg: "الرجاء إدخال جميع القيم"));
    }
  }
}



