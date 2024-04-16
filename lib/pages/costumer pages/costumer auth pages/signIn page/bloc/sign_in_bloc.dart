import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInCustomerBloc
    extends Bloc<SignInCustomerEvent, SignInCustomerState> {
  // here data pase
  SignInCustomerBloc() : super(SignInInitial()) {
    on<SignInCustomerEvent>((event, emit) {});
    on<AddSignInCustomerEvent>(signIn);
  }

  FutureOr<void> signIn(
      AddSignInCustomerEvent event, Emitter<SignInCustomerState> emit) async {
    emit(LoadingSignInCustomerState());
    if (event.email.trim().isNotEmpty && event.password.trim().isNotEmpty) {
      try {
        print('in the bloc');
        // here data pase
        await DBService().signIn(email: event.email, password: event.password);
        print('after');
        emit(SuccessSignInCustomerState(msg: "تم تسجيل الدخول بنجاح"));
      } on AuthException catch (p) {
        print(p);
        emit(ErrorSignInCustomerState(
            massage: "هناك مشكلة في عملية تسجيل الدخول"));
      } catch (error) {
        emit(ErrorSignInCustomerState(
            massage: "هناك مشكلة في عملية تسجيل الدخول"));
      }
    } else {
      emit(ErrorSignInCustomerState(massage: "الرجاء تعبئة جميع الحقول"));
    }
  }
}