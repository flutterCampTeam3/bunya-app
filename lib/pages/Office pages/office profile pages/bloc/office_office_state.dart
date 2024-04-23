part of 'office_office_bloc.dart';

@immutable
sealed class OfficeOfficeState {}

final class OfficeOfficeInitial extends OfficeOfficeState {}


class profilePostsSuccesOfficeState extends OfficeOfficeState{
  // final List<postModel> classPostId;
  // profilePostsSuccesState ({required this.classPostId});

}

 final class LoadingOfficeState extends OfficeOfficeState {}

 final class LoadingFollowOfficeState extends OfficeOfficeState {}

 final class AddFollowOfficeState extends OfficeOfficeState {
  final String msg;

  AddFollowOfficeState({required this.msg});
 }

 final class DeleteFollowOfficeState extends OfficeOfficeState {
  final String msg;

  DeleteFollowOfficeState({required this.msg});
 }

 final class CheckFollowOfficeState extends OfficeOfficeState {}

final class ErrorprofileShowpostOfficeState extends OfficeOfficeState {
  final String msg;

  ErrorprofileShowpostOfficeState({required this.msg});
}

final class ErrorFollowOfficeState extends OfficeOfficeState {
  final String msg;

  ErrorFollowOfficeState({required this.msg});
}

  final class CheckChatOfficeState extends OfficeOfficeState {
  final Room room;
  CheckChatOfficeState({required this.room});
  }
