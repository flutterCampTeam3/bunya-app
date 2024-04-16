part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpCustomerState {}

final class SignUpInitial extends SignUpCustomerState {}

final class LoadingSignUpCustomerState extends SignUpCustomerState {}

final class SuccessSignUpCustomerState extends SignUpCustomerState {
  final String msg;

  SuccessSignUpCustomerState({required this.msg});
}
class CustomerChoosImageEventShowImageState extends SignUpCustomerState{
  final File  PickedImage;
  CustomerChoosImageEventShowImageState(this.PickedImage);
}
final class ErrorSignUpCustomerState extends SignUpCustomerState {
  final String msg;

  ErrorSignUpCustomerState({required this.msg});
}
