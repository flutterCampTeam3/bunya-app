part of 'password_reset_bloc.dart';

@immutable
sealed class PasswordResetEvent {}

final class SendOtpEvent extends PasswordResetEvent {
  final String email;

  SendOtpEvent({required this.email});
}

final class VerifyOtpEvent extends PasswordResetEvent {
  final String otpToken;
  final String email;

  VerifyOtpEvent({required this.email, required this.otpToken});
}

final class ChangePasswordEvent extends PasswordResetEvent {
  final String password;
  final String rePassword;

  ChangePasswordEvent({required this.password, required this.rePassword});
}