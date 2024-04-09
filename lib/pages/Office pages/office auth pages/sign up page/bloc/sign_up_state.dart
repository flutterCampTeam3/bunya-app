part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class LoadingSignUpState extends SignUpState {}

final class SuccessSignUpState extends SignUpState {
  final String msg;

  SuccessSignUpState({required this.msg});
}

final class ErrorSignUpState extends SignUpState {
  final String msg;

  ErrorSignUpState({required this.msg});
}
