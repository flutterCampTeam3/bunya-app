part of 'nav_bloc.dart';

@immutable
sealed class NavOfficeEvent {}

final class ChangePageOfficeEvent extends NavOfficeEvent {
  final int index;

  ChangePageOfficeEvent({required this.index});
}
