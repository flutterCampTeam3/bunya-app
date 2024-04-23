import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:flutter/material.dart';

class DisconnectPage extends StatelessWidget {
  const DisconnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gapH30,
                  Image.asset("assets/images/NoConnection-bro.png"),
                  gapH20,
                  Text(
                    'No internet connection',
                    style: TextStyle(fontSize: 30, color: brown),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
