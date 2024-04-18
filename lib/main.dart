import 'package:bunya_app/data/service/supabase_configration.dart';
import 'package:bunya_app/pages/costumer%20pages/costumer%20auth%20pages/signIn%20page/signin_customer_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/Office pages/office auth pages/sign up page/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await databaseConfig();
  await setup();
  runApp(const MainApp());
  // (DevicePreview(
  //     enabled: !kReleaseMode, builder: (context) => const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        theme: ThemeData(
          fontFamily: GoogleFonts.aBeeZee().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        home: const Directionality(
            textDirection: TextDirection.rtl, child: SigninCustomerPage()));
  }
}
