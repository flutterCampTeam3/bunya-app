part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class ShowImagepostState extends PostState{
  final File  PickedImage;
  ShowImagepostState(this.PickedImage);
}