import 'package:bunya_app/pages/costumer_pages/home_page/accounts_list/account_list.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:bunya_app/pages/costumer_pages/categories_page/categories_page.dart';
import 'package:bunya_app/pages/costumer_pages/home_page/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:bunya_app/pages/intro%20pages/first_intro.dart';
import 'package:bunya_app/pages/Office%20pages/office%20auth%20pages/sign%20up%20page/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          fontFamily: GoogleFonts.aBeeZee().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        home: const Directionality(
            textDirection: TextDirection.rtl, child: HomePage()));
  }
}
