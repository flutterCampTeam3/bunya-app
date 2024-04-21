import 'package:flutter/material.dart';

Map<String, ThemeData> apTheme = {
  'Dark': ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 92, 92, 92),
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.white),
      
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 41, 34, 34),
    textTheme: TextTheme().apply(
      bodyColor: Colors.brown[100]
    ),
    brightness: Brightness.dark,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.brown[100],
      foregroundColor: Colors.grey,
    ) 
  ),
  'Light': ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
      titleTextStyle: TextStyle(color: Colors.black),
    ),
     scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme().apply(bodyColor: Colors.white),
       brightness: Brightness.light,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
      ) 
  ),
};
