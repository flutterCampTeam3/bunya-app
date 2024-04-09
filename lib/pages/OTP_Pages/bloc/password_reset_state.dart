part of 'password_reset_bloc.dart';

@immutable
sealed class PasswordResetState {}

final class PasswordResetInitial extends PasswordResetState {}

final class EmailVerifiedState extends PasswordResetState {
  final String msg;

  EmailVerifiedState({required this.msg});
}

final class OtpVerifiedState extends PasswordResetState {
  final String msg;

  OtpVerifiedState({required this.msg});
}

final class PasswordChangedState extends PasswordResetState {
  final String msg;

  PasswordChangedState({required this.msg});
}

final class OtpErrorState extends PasswordResetState {
  final String msg;

  OtpErrorState({required this.msg});
}

final class OtpLoadingState extends PasswordResetState {

}