import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  // here data pase
  bool userType = true;
  SignInBloc() : super(SignInInitial()) {
    on<SignInEvent>((event, emit) {});
    on<AddSignInEvent>(signIn);
    on<ResetPasswordEvent>(resetPass);
  }

  FutureOr<void> signIn(AddSignInEvent event, Emitter<SignInState> emit) async {
    emit(LoadingSignInState());
    if (event.email.trim().isNotEmpty && event.password.trim().isNotEmpty) {
      try {
        // here data pase
        await DBService().signIn(email: event.email, password: event.password);
        userType = await DBService().checkUserCustomer();
        emit(SuccessSignInState(msg: "تم تسجيل الدخول بنجاح"));
      } on AuthException catch (p) {
        print(p);
        emit(ErrorSignInState(massage: "هناك مشكلة في عملية تسجيل الدخول"));
      }
    } else {
      emit(ErrorSignInState(massage: "الرجاء تعبئة جميع الحقول"));
    }
  }

  FutureOr<void> resetPass(ResetPasswordEvent event, Emitter<SignInState> emit) async{
    emit(LoadingSignInState());
  }
}
