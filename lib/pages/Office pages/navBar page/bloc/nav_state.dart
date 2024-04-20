part of 'nav_bloc.dart';

@immutable
sealed class NavOfficeState {}

final class NavInitial extends NavOfficeState {}

final class ChangePageOfficeState extends NavOfficeState {}
