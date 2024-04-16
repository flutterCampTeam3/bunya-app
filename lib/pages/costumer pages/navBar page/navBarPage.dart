import 'package:bunya_app/pages/costumer%20pages/navBar%20page/bloc/nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class NavBarPage extends StatelessWidget {
  const NavBarPage({
    super.key,
  });

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
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                color: const Color.fromARGB(255, 223, 216, 208),
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.person_2_outlined),
                      onPressed: () {
                        bloc.currentIndex = 0;
                        bloc.add(ChangePageEvent(index: 0));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.category_outlined),
                      onPressed: () {
                        bloc.currentIndex = 1;
                        bloc.add(ChangePageEvent(index: 1));
                      },
                    ),
                    const SizedBox(width: 40), // Adjust spacing for FAB
                    IconButton(
                      icon: const Icon(Icons.messenger_outline),
                      onPressed: () {
                        bloc.currentIndex = 2;
                        bloc.add(ChangePageEvent(index: 2));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.home_outlined),
                      onPressed: () {
                        bloc.currentIndex = 3;
                        bloc.add(ChangePageEvent(index: 3));
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
                    'assets/images/bx_bot.svg',
                    height: 40,
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
