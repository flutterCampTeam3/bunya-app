part of 'like_bloc.dart';

@immutable
sealed class LikeEvent {}

final class AddLikeEvent extends LikeEvent {
  final postModel post;
  AddLikeEvent({required this.post});
}

final class CheckLikeEvent extends LikeEvent {
  final String id;
  CheckLikeEvent({required this.id});
}

final class DeleteLikeEvent extends LikeEvent {
  final String id;
  DeleteLikeEvent({required this.id});
}


final class GetLikeNumberEvent extends LikeEvent {
  final String id;
  GetLikeNumberEvent({required this.id});
}
