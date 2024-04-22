part of 'profile_office_bloc.dart';

@immutable
sealed class ProfileOfficeEvent {}

final class GetOfficeInfoEvent extends ProfileOfficeEvent {}

final class ActivateEditModeEvent extends ProfileOfficeEvent {}

final class DeactivateEditModeEvent extends ProfileOfficeEvent {}

final class UpdateOfficeInfoEvent extends ProfileOfficeEvent {
  final String description;
  final String email;
  final int phone;
  final String name;
  UpdateOfficeInfoEvent({
    required this.description,
    required this.email,
    required this.phone,
    required this.name,
  });
}

final class ShowFloowersEvent extends ProfileOfficeEvent {
  final String id;

  ShowFloowersEvent({required this.id});
}

final class SignOutEvent extends ProfileOfficeEvent {}
