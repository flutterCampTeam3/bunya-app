part of 'profile_posts_bloc.dart';

@immutable
sealed class ProfilePostsEvent {}

class ShowDataIdEvent extends ProfilePostsEvent {
  final String id;
  ShowDataIdEvent({required this.id});
}

class CheckFollowEvent extends ProfilePostsEvent {
  final String id;
  CheckFollowEvent({required this.id});
}

class AddFollowEvent extends ProfilePostsEvent {
  final String id;
  AddFollowEvent({required this.id});
}

class DeleteFollowEvent extends ProfilePostsEvent {
  final String id;
  DeleteFollowEvent({required this.id});
}

class CheckFollowNumberEvent extends ProfilePostsEvent {
  final String officeId;
  CheckFollowNumberEvent({required this.officeId});
}
