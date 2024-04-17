part of 'sign_in_bloc.dart';

@immutable
sealed class SignInCustomerEvent {}

class AddSignInCustomerEvent extends SignInCustomerEvent {
  final String email;
  final String password;
  AddSignInCustomerEvent({required this.email, required this.password});
}

class ResetPasswordCustomerEvent extends SignInCustomerEvent {
  final String email;
  ResetPasswordCustomerEvent({required this.email});
}
