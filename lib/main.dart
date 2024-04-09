import 'package:bunya_app/pages/costumer%20pages/navBar%20page/navBarPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NavBarPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
