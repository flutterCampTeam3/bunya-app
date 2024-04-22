import 'package:flutter/material.dart';

class NotificationOfficePage extends StatelessWidget {
  const NotificationOfficePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Column(
        children: [Text("Notifications")],
      )),
    );
  }
}
