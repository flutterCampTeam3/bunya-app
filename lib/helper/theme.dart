import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';

Map<String, ThemeData> apTheme = {
  'Dark': ThemeData(
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: brownColor,
          onPrimary: whiteBrown,
          secondary: white,
          onSecondary: darkGreyColor,
          error: red,
          onError: red,
          background: const Color.fromARGB(255, 41, 34, 34),
          onBackground: freewhiteBrown,
          surface: blackColor,
          onSurface: white),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 41, 34, 34),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 41, 34, 34),
      textTheme: const TextTheme()
          .apply(bodyColor: Colors.brown[100], displayColor: Colors.brown[100]),
      brightness: Brightness.dark,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.brown[100],
        foregroundColor: Colors.grey,
      )),
  'Light': ThemeData(
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: brown,
          onPrimary: whiteBrown,
          secondary: lightBrown,
          onSecondary: greyColor,
          error: red,
          onError: red,
          background: white,
          onBackground: page,
          surface: blackColor,
          onSurface: blackColor),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme().apply(bodyColor: Colors.white),
      brightness: Brightness.light,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
      )),
};
