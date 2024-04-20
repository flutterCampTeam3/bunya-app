part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpCustomerEvent {}

class CreateAccountCustomerEvent extends SignUpCustomerEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPass;
   bool isChecked=false;
  CreateAccountCustomerEvent(
      {required this.name, required this.email, required this.password,required this.phone,required this.confirmPass,required this.isChecked});
}

class CustomerChoosImageEvent extends SignUpCustomerEvent{

} 