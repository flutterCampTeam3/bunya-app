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

