part of 'profile_office_bloc.dart';

@immutable
sealed class ProfileOfficeState {}

final class ProfileOfficeInitial extends ProfileOfficeState {}

// final class ActivatedEditModeState extends ProfileOfficeState {
//   String name;
//   String email;

//   ActivatedEditModeState({
//     required this.email,
//     required this.name,
//   });
// }

final class DeactivatedEditModeState extends ProfileOfficeState {}

final class DisplayOfficeInfoState extends ProfileOfficeState {
  String name;
  String email;
  String description;
  int phone;
  DisplayOfficeInfoState(
      {required this.email,
      required this.name,
      required this.phone,
      required this.description});
}

final class ProfileLoadingState extends ProfileOfficeState {}

final class ProfileErrorState extends ProfileOfficeState {
  final String msg;

  ProfileErrorState({required this.msg});
}

final class SignedOutState extends ProfileOfficeState {
  final String msg;

  SignedOutState({required this.msg});
}
