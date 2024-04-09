import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  // here data pase
  SignInBloc() : super(SignInInitial()) {
    on<SignInEvent>((event, emit) {});
    on<AddSignInEvent>(signIn);
  }

  FutureOr<void> signIn(AddSignInEvent event, Emitter<SignInState> emit) async {
    emit(LoadingSignInState());
    if(event.email.trim().isNotEmpty && event.password.trim().isNotEmpty){
      try {
       // here data pase
      emit(SuccessSignInState(msg: "تم تسجيل الدخول بنجاح"));
    } on AuthException catch (p) {
      print(p);
      emit(ErrorSignInState(massage: "هناك مشكلة في عملية تسجيل الدخول"));
    }
    }else{
      emit(ErrorSignInState(massage: "الرجاء تعبئة جميع الحقول"));
    }
    
  }
}
