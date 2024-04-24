part of 'home_bloc.dart';

@immutable
sealed class HomeOfficesEvent {}


  class ShowDataOfficesEvent extends HomeOfficesEvent {}

  final class AddLikeHomeOfficesEvent extends HomeOfficesEvent {
  final postModel post;
  AddLikeHomeOfficesEvent({required this.post});
}

final class CheckLikeHomeOfficesEvent extends HomeOfficesEvent {
  final String id;
  CheckLikeHomeOfficesEvent({required this.id});
}

final class DeleteLikeHomeOfficesEvent extends HomeOfficesEvent {
  final String id;
  DeleteLikeHomeOfficesEvent({required this.id});
}

final class GetLikeNumberHomeOfficesEvent extends HomeOfficesEvent {
  final String id;
  GetLikeNumberHomeOfficesEvent({required this.id});
}
