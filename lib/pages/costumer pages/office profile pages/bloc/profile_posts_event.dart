part of 'profile_posts_bloc.dart';

@immutable
sealed class ProfilePostsEvent {}

class ShowDataIdEvent extends ProfilePostsEvent{
  final String id;
  ShowDataIdEvent({required this.id});
}

class CheckFollowEvent extends ProfilePostsEvent{
  final String id;
  CheckFollowEvent({required this.id});
}