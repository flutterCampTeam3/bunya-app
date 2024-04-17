part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class GetUserInfoEvent extends ProfileEvent {

}

final class ActivateEditModeEvent extends ProfileEvent {

}

final class DeactivateEditModeEvent extends ProfileEvent {

}

final class UpdateUserInfoEvent extends ProfileEvent {
  final String name;

  UpdateUserInfoEvent({required this.name,});
}

final class SignOutEvent extends ProfileEvent {
  
}