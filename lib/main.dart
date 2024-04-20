import 'package:bunya_app/data/service/supabase_configration.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:bunya_app/pages/Office%20pages/navBar%20page/navBarPage.dart';
import 'package:bunya_app/pages/costumer%20pages/costumer%20auth%20pages/signIn%20page/signin_customer_page.dart';
import 'package:bunya_app/pages/costumer%20pages/navBar%20page/navBarPage.dart';
import 'package:bunya_app/pages/intro%20pages/disconnect_page.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:get_it/get_it.dart';
// import 'package:device_preview/device_preview.dart';import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  InternetConnection().onStatusChange.listen((status) async {
    if (status == InternetStatus.connected) {
      await databaseConfig();
      final locator = GetIt.I.get<DBService>();
      await locator.getSession();
      runApp(const MainApp());
    } else {
      runApp(const DisconnectPage());
    }
  });

  // (DevicePreview(
  //     enabled: !kReleaseMode, builder: (context) => const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<DBService>();
    final bool isSignIn = locator.isSession;
    return MaterialApp(
        theme: ThemeData(
          fontFamily: GoogleFonts.aBeeZee().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        home: Directionality(
            textDirection: TextDirection.rtl,
            child: locator.token.isNotEmpty
                ? isSignIn
                    ? const NavBarPage()
                    : const NavBarOfficePage()
                : const SigninCustomerPage()));
  }
}
