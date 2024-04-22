part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class ChoseImagePostEvent extends PostEvent{}

class UploadPost extends PostEvent{}
