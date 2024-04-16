import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavOfficeBloc extends Bloc<NavOfficeEvent, NavOfficeState> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const PageWidget(title: 'Page 1'),
    const PageWidget(title: 'Page 2'),
    const PageWidget(title: 'Page 3'),
    const PageWidget(title: 'Page 4'),
  ];

  NavOfficeBloc() : super(NavInitial()) {
    on<NavOfficeEvent>((event, emit) {});
    on<ChangePageOfficeEvent>(changePage);
  }

  FutureOr<void> changePage(ChangePageOfficeEvent event, Emitter<NavOfficeState> emit) {
    currentIndex = event.index;
    emit(ChangePageOfficeState());
  }
}

class PageWidget extends StatelessWidget {
  final String title;

  const PageWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
