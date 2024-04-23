part of 'profile_office_bloc.dart';

@immutable
sealed class ProfileOfficeState {}

final class ProfileOfficeInitial extends ProfileOfficeState {}

final class ProfilOfficeSuccessOfficeState extends ProfileOfficeState {
  String msg;
  ProfilOfficeSuccessOfficeState({required this.msg});
}

class profilePostsSuccesState extends ProfileOfficeState {}

final class LoadingState extends ProfileOfficeState {}

final class DisplayOfficeInfoState extends ProfileOfficeState {}

final class ActivatedEditModeOfficeState extends ProfileOfficeState {
  String name;
  String email;
  ActivatedEditModeOfficeState({
    required this.email,
    required this.name,
  });
}

final class ProfileLoadingState extends ProfileOfficeState {}

final class DeactivatedEditModeOfficeState extends ProfileOfficeState {}


final class ProfileOfficeErrorState extends ProfileOfficeState {
  final String msg;

  ProfileOfficeErrorState({required this.msg});
}

final class SignedOutState extends ProfileOfficeState {
  final String msg;

  SignedOutState({required this.msg});
}

class dataFlowrsSuccesState extends ProfileOfficeState {
  final List<OfficesModel> classOffices;

  dataFlowrsSuccesState({required this.classOffices});
}

final class LaudLikeOfficeState extends ProfileOfficeState {}

final class AddLikeOfficeState extends ProfileOfficeState {}

final class DeleteLikeOfficeState extends ProfileOfficeState {}

final class CheckLikeOfficeState extends ProfileOfficeState {}

final class ErrorLikeOfficeState extends ProfileOfficeState {
  final String msg;

  ErrorLikeOfficeState({required this.msg});
}