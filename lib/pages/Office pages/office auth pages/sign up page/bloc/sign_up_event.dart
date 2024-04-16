part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class CreateAccountEvent extends SignUpEvent {
  final String name;
  final String email;
  final String cr;
  // final String id;
  final String password;
  final String confirmPass;
  bool isChecked = false;
  CreateAccountEvent(
      {required this.name,
      required this.email,
      required this.password,
      required this.cr,
      // required this.id,
      required this.confirmPass,
      required this.isChecked});
}
