part of 'drak_mode_bloc.dart';

@immutable
sealed class DrakModeEvent {}

class UpdateThemeEvent extends DrakModeEvent{}

class GetThemeEvent extends DrakModeEvent {}
