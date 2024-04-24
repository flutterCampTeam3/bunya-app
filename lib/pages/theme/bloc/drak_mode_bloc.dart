import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/service/git_it.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:bunya_app/helper/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'drak_mode_event.dart';
part 'drak_mode_state.dart';

class DrakModeBloc extends Bloc<DrakModeEvent, DrakModeState> {
  final locator = GetIt.I.get<DBService>();
  late ThemeData themeInfo;
  bool light = false;

  DrakModeBloc() : super(DrakModeInitial()) {
    themeInfo = apTheme[locator.currentTheme]!;
    on<UpdateThemeEvent>((event, emit) {
      locator.changeTheme();
      themeInfo = apTheme[locator.currentTheme]!;
      emit(ShowThemeState(themeInfo, locator.currentTheme));
    });

    on<GetThemeEvent>((event, emit) {
      locator.getTheme();
      themeInfo = apTheme[locator.currentTheme]!;
      locator.currentTheme == 'Light' ? light = true : light = false;
      emit(ShowThemeState(themeInfo, locator.currentTheme));
    });
  }
}
