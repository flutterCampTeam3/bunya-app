part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}


  class ShowDataEvent extends HomeEvent {}


final class AddLikeHomeEvent extends HomeEvent {
  final postModel post;
  AddLikeHomeEvent({required this.post});
}

final class CheckLikeHomeEvent extends HomeEvent {
  final String id;
  CheckLikeHomeEvent({required this.id});
}

final class DeleteLikeHomeEvent extends HomeEvent {
  final String id;
  DeleteLikeHomeEvent({required this.id});
}


final class GetLikeNumberHomeEvent extends HomeEvent {
  final String id;
  GetLikeNumberHomeEvent({required this.id});
}
