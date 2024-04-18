import 'package:bunya_app/pages/costumer%20pages/navBar%20page/bloc/nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class NavBarPage extends StatelessWidget {
  const NavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBloc(),
      child: BlocBuilder<NavBloc, NavState>(
        builder: (context, state) {
          return Builder(builder: (context) {
            final bloc = context.read<NavBloc>();
            return Scaffold(
              body: bloc.pages[bloc.currentIndex],
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(30.0), // Adjust the radius as needed
                    topRight:
                        Radius.circular(30.0), // Adjust the radius as needed
                  ),
                ),
                child: BottomNavigationBar(
                  currentIndex: bloc.currentIndex,
                  onTap: (pageIndex) {
                    bloc.currentIndex = pageIndex;
                    bloc.add(ChangePageEvent(index: pageIndex));
                  },
                  enableFeedback: false,
                  showUnselectedLabels: true,
                  showSelectedLabels: true,
                  useLegacyColorScheme: false,
                  elevation: 3,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: const Color.fromARGB(255, 223, 216, 208),
                  unselectedItemColor: const Color.fromARGB(255, 84, 84, 84),
                  selectedItemColor: const Color.fromARGB(255, 158, 141, 123),
                  selectedLabelStyle: const TextStyle(
                    color: Color.fromARGB(255, 158, 141, 123),
                  ),
                  unselectedLabelStyle: const TextStyle(color: Colors.black),
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_2_outlined),
                      label: 'الحساب',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.category_outlined),
                      label: 'الفئات',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.messenger_outline),
                      label: 'الرسائل',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: 'الرئيسية',
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // Handle the floating button press
                },
                shape: const CircleBorder(
                    eccentricity: 1,
                    side: BorderSide(color: Colors.white, width: 4)),
                // Border.all(color: Colors.white, width: 3, strokeAlign: 2),
                backgroundColor: const Color.fromARGB(255, 223, 216, 208),
                // child: SvgPicture.asset('assets/images/bx_bot.svg',
                //     colorFilter: const ColorFilter.mode(
                //         Color.fromARGB(255, 84, 84, 84), BlendMode.srcIn),
                //     semanticsLabel: 'Acme Logo'),
                //  const Icon(
                //   Icons.add,
                //   color: Color.fromARGB(255, 84, 84, 84),
                // ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            );
          });
        },
      ),
    );
  }
}
