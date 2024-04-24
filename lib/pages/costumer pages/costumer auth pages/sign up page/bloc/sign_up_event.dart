part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpCustomerEvent {}

class CreateAccountCustomerEvent extends SignUpCustomerEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPass;
  CreateAccountCustomerEvent(
      {required this.name, required this.email, required this.password,required this.phone,required this.confirmPass});
}

class CustomerChoosImageEvent extends SignUpCustomerEvent{

}