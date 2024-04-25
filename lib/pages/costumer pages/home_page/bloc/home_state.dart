part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}


class datahomeSuccesState extends HomeState {
  final List<OfficesModel> classOffices;
   final List<postModel> classPost;
  datahomeSuccesState({required this.classOffices,required this.classPost});
}
 final class LoadingState extends HomeState {}

final class ErrorShowpostState extends HomeState {
  final String msg;

  ErrorShowpostState({required this.msg});
}

final class LaudLikeHomeState extends HomeState {}

final class AddLikeHomeState extends HomeState {}

final class DeleteLikeHomeState extends HomeState {}

final class CheckLikeHomeState extends HomeState {}

final class ErrorLikeHomeState extends HomeState {
  final String msg;

  ErrorLikeHomeState({required this.msg});
}


