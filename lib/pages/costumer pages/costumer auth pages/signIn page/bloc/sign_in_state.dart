part of 'sign_in_bloc.dart';

@immutable
sealed class SignInCustomerState {}

final class SignInInitial extends SignInCustomerState {}

final class LoadingSignInCustomerState extends SignInCustomerState {}

final class SuccessSignInCustomerState extends SignInCustomerState {
  final String msg;

  SuccessSignInCustomerState({required this.msg});
}

final class SuccessResetCustomerState extends SignInCustomerState {
  final String msg;

  SuccessResetCustomerState({required this.msg});
}

final class ErrorSignInCustomerState extends SignInCustomerState {
  final String massage;

  ErrorSignInCustomerState({required this.massage});
}
