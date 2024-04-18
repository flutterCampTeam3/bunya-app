import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Office%20pages/navBar%20page/bloc/nav_bloc.dart';
import 'package:bunya_app/pages/costumer%20pages/navBar%20page/bloc/nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class NavBarOfficePage extends StatelessWidget {
  const NavBarOfficePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavOfficeBloc(),
      child: BlocBuilder<NavOfficeBloc, NavOfficeState>(
        builder: (context, state) {
          return Builder(builder: (context) {
            final bloc = context.read<NavOfficeBloc>();
            return Scaffold(
              body: bloc.pages[bloc.currentIndex],
              bottomNavigationBar: BottomAppBar(
                padding: const EdgeInsets.all(2),
                // padding: const EdgeInsets.only(top: 0),
                height: 60,
                notchMargin: 9,
                shape: const CircularNotchedRectangle(),
                color: const Color.fromARGB(255, 223, 216, 208),
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Column(
                        children: [
                          Icon(
                            Icons.person_2_outlined,
                            color:
                                bloc.currentIndex == 0 ? brownNavSelect : null,
                          ),
                          Text(
                            "الحساب",
                            style: TextStyle(
                              fontSize: 11,
                              color: bloc.currentIndex == 0
                                  ? brownNavSelect
                                  : null,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        bloc.currentIndex = 0;
                        bloc.add(ChangePageOfficeEvent(index: 0));
                      },
                    ),
                    IconButton(
                      icon: Column(
                        children: [
                          Icon(
                            Icons.category_outlined,
                            color:
                                bloc.currentIndex == 1 ? brownNavSelect : null,
                          ),
                          Text(
                            "الفئات",
                            style: TextStyle(
                              fontSize: 11,
                              color: bloc.currentIndex == 1
                                  ? brownNavSelect
                                  : null,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        bloc.currentIndex = 1;
                        bloc.add(ChangePageOfficeEvent(index: 1));
                      },
                    ),
                    const SizedBox(width: 40), // Adjust spacing for FAB
                    IconButton(
                      icon: Column(
                        children: [
                          Icon(
                            Icons.messenger_outline,
                            color:
                                bloc.currentIndex == 2 ? brownNavSelect : null,
                          ),
                          Text(
                            "الرسائل",
                            style: TextStyle(
                              fontSize: 11,
                              color: bloc.currentIndex == 2
                                  ? brownNavSelect
                                  : null,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        bloc.currentIndex = 2;
                        bloc.add(ChangePageOfficeEvent(index: 2));
                      },
                    ),
                    IconButton(
                      icon: Column(
                        children: [
                          Icon(
                            Icons.home_outlined,
                            color:
                                bloc.currentIndex == 3 ? brownNavSelect : null,
                          ),
                          Text(
                            "الرئيسية",
                            style: TextStyle(
                              fontSize: 11,
                              color: bloc.currentIndex == 3
                                  ? brownNavSelect
                                  : null,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        bloc.currentIndex = 3;
                        bloc.add(ChangePageOfficeEvent(index: 3));
                      },
                    ),
                  ],
                ),
              ),
              floatingActionButton: SizedBox(
                width: 80,
                height: 80,
                child: FloatingActionButton(
                  onPressed: () {
                    // Handle the floating button press
                  },
                  shape: const CircleBorder(),
                  backgroundColor: const Color.fromARGB(255, 223, 216, 208),
                  child: SvgPicture.asset(
                    'assets/images/addIcon.svg',
                    height: 45,
                    colorFilter: const ColorFilter.mode(
                        Color.fromARGB(255, 84, 84, 84), BlendMode.srcIn),
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniCenterDocked,
            );
          });
        },
      ),
    );
  }
}
