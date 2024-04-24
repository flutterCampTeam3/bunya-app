part of 'drak_mode_bloc.dart';

@immutable
sealed class DrakModeState {}

final class DrakModeInitial extends DrakModeState {}

class ShowThemeState extends DrakModeState {
  ThemeData themeData;
  String currentTheme;

  ShowThemeState(this.themeData, this.currentTheme);
}
