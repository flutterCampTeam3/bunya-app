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

