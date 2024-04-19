part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ActivatedEditModeState extends ProfileState {
  String name;
  String email;

  ActivatedEditModeState({
    required this.email,
    required this.name,
  });
}

final class DeactivatedEditModeState extends ProfileState {}

final class DisplayUserInfoState extends ProfileState {
  String name;
  String email;
    String image;
  int phone;
  DisplayUserInfoState(
      {required this.email, required this.name, required this.phone, required this.image});
}

final class ProfilSuccessState extends ProfileState {
  final String msg;

  ProfilSuccessState({required this.msg});
}

final class ProfileLoadingState extends ProfileState {}

final class ProfileErrorState extends ProfileState {
  final String msg;

  ProfileErrorState({required this.msg});
}

final class SignedOutState extends ProfileState {
  final String msg;

  SignedOutState({required this.msg});
}
