import 'package:bunya_app/data/service/supabase_configration.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:bunya_app/pages/Office%20pages/navBar%20page/navBarPage.dart';
import 'package:bunya_app/pages/costumer%20pages/aichat/chat.dart';
import 'package:bunya_app/pages/costumer%20pages/navBar%20page/navBarPage.dart';
import 'package:bunya_app/pages/intro%20pages/disconnect_page.dart';
import 'package:bunya_app/pages/intro%20pages/first_intro.dart';
import 'package:bunya_app/pages/theme/bloc/drak_mode_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
// import 'package:device_preview/device_preview.dart';import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

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
    return BlocProvider(
      create: (context) => DrakModeBloc()..add(GetThemeEvent()),
      child:
          BlocBuilder<DrakModeBloc, DrakModeState>(builder: (context, state) {
        final bloc = context.read<DrakModeBloc>();
              return MaterialApp(
                  theme: bloc.themeInfo,
                  debugShowCheckedModeBanner: false,
                  home: Directionality(
                      textDirection: TextDirection.rtl,
                      child:  isSignIn
                          ? locator.userType
                              ? const NavBarPage()
                              : const NavBarOfficePage()
                          : const introPage()));
            }),
          );
        }

}
