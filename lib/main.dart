import 'package:bunya_app/pages/Office_pages/profile_page/edit_page.dart';
import 'package:bunya_app/pages/Office_pages/profile_page/profile_page.dart';
import 'package:bunya_app/pages/costumer_pages/categories_page/categories_page.dart';
import 'package:bunya_app/pages/costumer_pages/home_page/home_page.dart';
import 'package:bunya_app/pages/costumer_pages/profile_page/profile_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
            textDirection: TextDirection.rtl, child: ProfilePageCustomer()));
  }
}
