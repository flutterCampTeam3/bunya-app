part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class LoadingSignInState extends SignInState {}

final class SuccessSignInState extends SignInState {
  final String msg;

  SuccessSignInState({required this.msg});
}

final class SuccessResetState extends SignInState {
  final String msg;

  SuccessResetState({required this.msg});
}

final class ErrorSignInState extends SignInState {
  final String massage;

  ErrorSignInState({required this.massage});
}
