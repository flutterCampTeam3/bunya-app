part of 'profile_office_bloc.dart';

@immutable
sealed class ProfileOfficeEvent {}

class ShowDataOfficesIdEvent extends ProfileOfficeEvent {}

final class GetOfficeInfoOfficeEvent extends ProfileOfficeEvent {}

final class ActivateEditModeOfficeEvent extends ProfileOfficeEvent {}

final class DeactivateEditModeOfficeEvent extends ProfileOfficeEvent {}

final class UpdateOfficeInfoOfficeEvent extends ProfileOfficeEvent {
  final String description;
  final String email;
  final int phone;
  final String name;
  UpdateOfficeInfoOfficeEvent({
    required this.description,
    required this.email,
    required this.phone,
    required this.name,
  });
}

final class SignOutOfficeEvent extends ProfileOfficeEvent {}

final class CheckFollowNumberOfOfficeEvent extends ProfileOfficeEvent {}
