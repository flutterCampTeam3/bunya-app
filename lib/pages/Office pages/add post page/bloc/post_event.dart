part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class ChoseImagePostEvent extends PostEvent {}

class UploadPost extends PostEvent {
  final String bucketName;
  final String fileName;

  UploadPost({required this.bucketName, required this.fileName});
}

class UploadDesc extends PostEvent {
  final String desc;

  UploadDesc({required this.desc});
}

  

  