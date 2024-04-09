import 'package:bunya_app/pages/Office%20pages/office%20auth%20pages/sign%20up%20page/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/OTP_Pages/verify_email_page.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child:  MaterialApp(
        builder: (context, child) {
          return Directionality(textDirection: TextDirection.rtl, child: child!);
        },
        debugShowCheckedModeBanner: false,
        home: VerifyEmailPage()),
    );
  }
}
