import 'package:bunya_app/pages/intro%20pages/first_intro.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: introPage()
      
      /*Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
      */
    );
  }
}
