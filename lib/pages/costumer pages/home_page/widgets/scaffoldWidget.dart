import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/widgets/appbar_widget.dart';
import 'package:bunya_app/pages/supportPage/support_page.dart';
import 'package:bunya_app/pages/theme/bloc/drak_mode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget(
      {super.key, required this.hasAppBar, required this.body});
  final bool hasAppBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrakModeBloc, DrakModeState>(
      builder: (context, state) {
        final bloc = context.read<DrakModeBloc>();

        return Scaffold(
          appBar: hasAppBar
              ? const PreferredSize(
                  preferredSize: Size(90, 40),
                  child: AppBarWidget(),
                )
              : null,
          endDrawer: hasAppBar

              ///--------------- drawer design
              ? Drawer(
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: ListView(
                      children: [
                        const DrawerHeader(
                          child: Center(
                            child: Text(
                              'الاعدادات والخصوصية',
                              style: TextStyle(
                                  // color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        gapH5,
                        const ListTile(
                          title: Text(
                            'المحتوى و العرض ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onBackground,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.language),
                                iconColor: blackColor,
                                title: Text(
                                  'اللغة',
                                  style: TextStyle(
                                      fontSize: 20, color: blackColor),
                                ),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: bloc.light
                                    ? const Icon(Icons.mode_night_outlined)
                                    : const Icon(
                                        Icons.sunny,
                                      ),
                                iconColor: blackColor,
                                title: Text(
                                  'الوضع الليلي',
                                  style: TextStyle(
                                      fontSize: 20, color: blackColor),
                                ),
                                onTap: () {
                                  bloc.add(UpdateThemeEvent());
                                  bloc.add(GetThemeEvent());
                                  // here the buttun to switch the mode
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.person_pin_circle),
                                iconColor: blackColor,
                                title: Text(
                                  'إمكانيات الوصول',
                                  style: TextStyle(
                                      fontSize: 20, color: blackColor),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        gapH60,
                        const ListTile(
                          title: Text(
                            'الدعم ', // Add your title text here
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onBackground,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(
                                  Icons.report_problem,
                                ),
                                iconColor: blackColor,
                                title: Text(
                                  'إبلاغ عن مشكلة ',
                                  style: TextStyle(
                                      fontSize: 20, color: blackColor),
                                ),
                                onTap: () {
                                  context.pushTo(view: const SupportPage());
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              /////////////------------
              : null,
          body: body,
        );
      },
    );
  }
}
