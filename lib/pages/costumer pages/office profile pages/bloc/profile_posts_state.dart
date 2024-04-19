part of 'profile_posts_bloc.dart';

@immutable
sealed class ProfilePostsState {}

final class ProfilePostsInitial extends ProfilePostsState {}

class profilePostsSuccesState extends ProfilePostsState{
  final List<postModel> classPostId;
  profilePostsSuccesState ({required this.classPostId});

}

 final class LoadingState extends ProfilePostsState {}
 final class CheckFollow extends ProfilePostsState {}

final class ErrorprofileShowpostState extends ProfilePostsState {
  final String msg;

  ErrorprofileShowpostState({required this.msg});
}