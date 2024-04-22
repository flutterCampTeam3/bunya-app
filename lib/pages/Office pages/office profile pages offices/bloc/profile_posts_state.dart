part of 'profile_posts_bloc.dart';


sealed class ProfilePostsState {}

final class ProfilePostsInitial extends ProfilePostsState {}

class profilePostsSuccesState extends ProfilePostsState{
  // final List<postModel> classPostId;
  // profilePostsSuccesState ({required this.classPostId});

}

 final class LoadingState extends ProfilePostsState {}

 final class LoadingFollowState extends ProfilePostsState {}

 final class AddFollowState extends ProfilePostsState {
  final String msg;

  AddFollowState({required this.msg});
 }

 final class DeleteFollowState extends ProfilePostsState {
  final String msg;

  DeleteFollowState({required this.msg});
 }

 final class CheckFollowState extends ProfilePostsState {}

final class ErrorprofileShowpostState extends ProfilePostsState {
  final String msg;

  ErrorprofileShowpostState({required this.msg});
}

final class ErrorFollowState extends ProfilePostsState {
  final String msg;

  ErrorFollowState({required this.msg});
}