import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/pages/Messages_pages/messages_page.dart';
import 'package:bunya_app/pages/costumer%20pages/categories_page/categories_page.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/home_page.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePageCustomer(),
    const MessageListPage(),
    const CategoriesPage(),
     ProfilePageCustomer(),
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
