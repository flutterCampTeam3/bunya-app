import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const PageWidget(title: 'Page 1'),
    const PageWidget(title: 'Page 2'),
    const PageWidget(title: 'Page 3'),
    const PageWidget(title: 'Page 4'),
  ];

  NavBloc() : super(NavInitial()) {
    on<NavEvent>((event, emit) {});
    on<ChangePageEvent>(changePage);
  }

  FutureOr<void> changePage(ChangePageEvent event, Emitter<NavState> emit) {
    currentIndex = event.index;
    emit(ChangePageState());
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
