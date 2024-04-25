part of 'nav_bloc.dart';

@immutable
sealed class NavEvent {}

final class ChangePageEvent extends NavEvent {
  final int index;

  ChangePageEvent({required this.index});
}
