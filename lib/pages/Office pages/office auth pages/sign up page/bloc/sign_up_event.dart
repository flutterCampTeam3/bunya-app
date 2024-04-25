part of 'sign_up_bloc.dart';


sealed class SignUpEvent {}

class CreateAccountEvent extends SignUpEvent {
  final String name;
  final String email;
  final String cr;
  // final String id;
  final String password;
  final String confirmPass;
  bool isChecked = false;

  CreateAccountEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.cr,
    // required this.id,
    required this.confirmPass,
  });
}

class CreateAccountprofileEvent extends SignUpEvent {
  final String info;
  final String location;
  final String phone;
  final String name;
  final String email;
  final String cr;
  final String departmentId;
  final String password;
  final String bucketName;
  final String fileName;

  CreateAccountprofileEvent({
    required this.info,
    required this.location,
    required this.phone,
    required this.name,
    required this.email,
    required this.cr,
    required this.departmentId,
    required this.password,
    required this.bucketName,
    required this.fileName,
  });
}

class ChoosImageEvent extends SignUpEvent {}

class UploadProfileOfficeImage extends SignUpEvent {
  final String bucketName;
  final String fileName;

  UploadProfileOfficeImage({
    required this.bucketName,
    required this.fileName,
  });
}
