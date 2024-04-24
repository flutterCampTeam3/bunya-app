part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}
// class FetchUserInfoEvent extends ProfileEvent {}

final class GetUserInfoEvent extends ProfileEvent {}

final class ActivateEditModeEvent extends ProfileEvent {}

final class DeactivateEditModeEvent extends ProfileEvent {}

final class UpdateUserInfoEvent extends ProfileEvent {
  final String name;
  final String email;
  final int phone;
  UpdateUserInfoEvent({
    required this.name,
    required this.email,
    required this.phone,
  });
}
final class ShowFloowersEvent extends ProfileEvent {
 
}

final class SignOutEvent extends ProfileEvent {}
