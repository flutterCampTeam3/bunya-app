part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}


final class ActivatedEditModeState extends ProfileState {

}

final class DeactivatedEditModeState extends ProfileState {
  
}

final class DisplayUserInfoState extends ProfileState {
  final String name;
  final String email;

  DisplayUserInfoState({required this.email, required this.name,});
}

final class ProfileLoadingState extends ProfileState {

}

final class ProfileErrorState extends ProfileState {
  final String msg;

  ProfileErrorState({required this.msg});
}

final class SignedOutState extends ProfileState {
  final String msg;

  SignedOutState({required this.msg});
}