part of 'home_bloc.dart';

@immutable
sealed class HomeOfficesState {}

final class HomeInitial extends HomeOfficesState {}


class datahomeSuccesOfficesState extends HomeOfficesState {
  final List<OfficesModel> classOffices;
   final List<postModel> classPost;
  datahomeSuccesOfficesState({required this.classOffices,required this.classPost});
}
 final class LoadingState extends HomeOfficesState {}

final class ErrorOfficesState extends HomeOfficesState {
  final String msg;

  ErrorOfficesState({required this.msg});
}


final class LaudLikeHomeOfficesState extends HomeOfficesState {}

final class AddLikeHomeOfficesState extends HomeOfficesState {}

final class DeleteLikeHomeOfficesState extends HomeOfficesState {}

final class CheckLikeHomeOfficesState extends HomeOfficesState {}

final class ErrorLikeHomeOfficesState extends HomeOfficesState {
  final String msg;

  ErrorLikeHomeOfficesState({required this.msg});
}
