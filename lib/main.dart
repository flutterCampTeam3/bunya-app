import 'package:bunya_app/data/service/supabase_configration.dart';
import 'package:bunya_app/pages/costumer%20pages/costumer%20auth%20pages/sign%20up%20page/signup_page.dart';
import 'package:bunya_app/pages/costumer%20pages/office%20profile%20pages/profile_office.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/profile_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/Office pages/office auth pages/sign up page/profile_signup.dart';
import 'pages/Office pages/office auth pages/sign up page/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await databaseConfig();
  await setup();
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
            textDirection: TextDirection.rtl, child: ProfilePageOfficeCustomur()));
  }
}
