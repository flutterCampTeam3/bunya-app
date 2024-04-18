part of 'profile_office_bloc.dart';

@immutable
sealed class ProfileOfficeEvent {}

final class GetOfficeInfoEvent extends ProfileOfficeEvent {}

final class ActivateEditModeEvent extends ProfileOfficeEvent {}

final class DeactivateEditModeEvent extends ProfileOfficeEvent {}

final class UpdateUserInfoEvent extends ProfileOfficeEvent {
  final String description;
  final String email;
  final int phone;
  final String address;
  UpdateUserInfoEvent({
    required this.description,
    required this.email,
    required this.phone,
    required this.address,
  });
}

final class SignOutEvent extends ProfileOfficeEvent {}
