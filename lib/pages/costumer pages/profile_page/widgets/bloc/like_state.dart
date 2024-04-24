part of 'like_bloc.dart';

@immutable
sealed class LikeState {}

final class LikeInitial extends LikeState {}

final class LaudLikeState extends LikeState {}

final class AddLikeState extends LikeState {}

final class DeleteLikeState extends LikeState {}

final class CheckLikeState extends LikeState {}

final class ErrorLikeState extends LikeState {
  final String msg;

  ErrorLikeState({required this.msg});
}
