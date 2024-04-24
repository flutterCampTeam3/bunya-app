import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/pages/Messages_pages/messages_page.dart';
import 'package:bunya_app/pages/Office%20pages/home_page/home_page_office.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/profile_Office_pagee.dart';
import 'package:bunya_app/pages/costumer%20pages/categories_page/categories_page.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavOfficeBloc extends Bloc<NavOfficeEvent, NavOfficeState> {
  int currentIndex = 3;

  final List<Widget> pages = [
    ProfilePageOffice(),
    const CategoriesPage(),
    const MessageListPage(),
    const HomePageOffice(),
  ];

  NavOfficeBloc() : super(NavInitial()) {
    on<NavOfficeEvent>((event, emit) {});
    on<ChangePageOfficeEvent>(changePage);
  }

  FutureOr<void> changePage(
      ChangePageOfficeEvent event, Emitter<NavOfficeState> emit) {
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
