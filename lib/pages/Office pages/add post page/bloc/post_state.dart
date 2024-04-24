part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}


final class ShowImagepostState extends PostState{
  final File  PickedImage;
  ShowImagepostState(this.PickedImage);
}

 class DisplayDesc extends PostState{
  final List  <postModel> desc;
  DisplayDesc({required this.desc});
}

final class successState extends PostState {}      