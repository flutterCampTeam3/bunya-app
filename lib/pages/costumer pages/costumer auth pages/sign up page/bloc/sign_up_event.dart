part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpCustomerEvent {}

class CreateAccountCustomerEvent extends SignUpCustomerEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPass;
  final String bucketName;
  final String fileName;

  CreateAccountCustomerEvent({required this.name, required this.email, required this.phone, required this.password, required this.confirmPass, required this.bucketName, required this.fileName});
  
}
class UploadProfileImage extends SignUpCustomerEvent {
  final String bucketName;
  final String fileName;

  UploadProfileImage({required this.bucketName, required this.fileName});
}

class CustomerChoosImageEvent extends SignUpCustomerEvent{

}    