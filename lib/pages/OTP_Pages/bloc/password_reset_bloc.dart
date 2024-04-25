import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/service/supabase%20services/services.dart';
import 'package:meta/meta.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc() : super(PasswordResetInitial()) {
    on<PasswordResetEvent>((event, emit) {});

    on<SendOtpEvent>(sendOtp);
    on<VerifyOtpEvent>(verifyOtp);
    on<ChangePasswordEvent>(changePassword);
    on<ResendOtpEvent>(resendOtp);
  }

  FutureOr<void> sendOtp(
      SendOtpEvent event, Emitter<PasswordResetState> emit) async {
    emit(OtpLoadingState());
    if (event.email.trim().isNotEmpty) {
      try {
        //database Here
        await DBService().sendOtp(email: event.email);
        emit(EmailVerifiedState(
            msg:
                "تم إرسال الرمز إلى بريدك الإلكتروني، يرجى التحقق وكتابة الرمز"));
      } catch (p) {
        print(p);
        emit(OtpErrorState(msg: "الايميل غير صحيح"));
      }
    } else {
      emit(OtpErrorState(msg: "الرجاء إدخال الايميل الخاص بك"));
    }
  }

  FutureOr<void> verifyOtp(
      VerifyOtpEvent event, Emitter<PasswordResetState> emit) async {
    emit(OtpLoadingState());
    if (event.otpToken.trim().isNotEmpty && event.otpToken.length == 6) {
      try {
        //Here data base
        await DBService()
            .verifyOtp(otpToken: event.otpToken, email: event.email);
        emit(OtpVerifiedState(
            msg:
                "تم التحقق من الرمز بنجاح، يمكنك الآن تغيير كلمة السر الخاصة بك"));
      } catch (e) {
        emit(OtpErrorState(msg: "الرمز المدخل غير صحيح"));
      }
    } else {
      emit(OtpErrorState(msg: "الرجاء إدخال الرمز كاملاً"));
    }
  }

  FutureOr<void> changePassword(
      ChangePasswordEvent event, Emitter<PasswordResetState> emit) async {
    emit(OtpLoadingState());
    if (event.password.trim().isNotEmpty &&
        event.rePassword.trim().isNotEmpty) {
      if (event.password == event.rePassword) {
        try {
          //Here data base
          await DBService().resetPassword(newPassword: event.password);
          emit(PasswordChangedState(msg: "تم تغيير كلمة السر بنجاح"));
        } catch (e) {
          emit(OtpErrorState(
              msg:
                  "كلمة السر غير متوفرة (يجب أن تكون جديدة و ٦ أحرف على الأقل)"));
        }
      } else {
        emit(OtpErrorState(msg: "كلمتا السر غير متطابقتان"));
      }
    } else {
      emit(OtpErrorState(msg: "يرجى إدخال جميع القيم"));
    }
  }

  FutureOr<void> resendOtp(
      ResendOtpEvent event, Emitter<PasswordResetState> emit) async {
    emit(OtpLoadingState());
    try {
      await DBService().sendOtp(email: event.email);
      emit(AuthOtpResentState(msg: "تم إرسال رمز التحقق الجديد"));
    } catch (error) {
      print(error);
      emit(OtpErrorState(msg: "الإيميل غير صحيح"));
    }
  }
}
