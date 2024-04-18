import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Office%20pages/office%20auth%20pages/signIn%20page/signin_page.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/bloc/profile_bloc.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/edit_page.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/follower_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/image_aacount_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/information_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePageCustomer extends StatelessWidget {
  const ProfilePageCustomer({super.key});

  @override

  // bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: BlocProvider(
          create: (context) => ProfileBloc(),
          child: Builder(builder: (context) {
            final bloc = context.read<ProfileBloc>();
            bloc.add(GetUserInfoEvent());
            return BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is DisplayUserInfoState) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                        backgroundColor: whiteColor,
                        body: SafeArea(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "حسابي",
                                          style: TextStyle(fontSize: 24),
                                        )),
                                    gapH10,
                                    Row(
                                      children: [
                                        ImageAacountWodget(
                                          path:
                                              'assets/images/profile_image.png',
                                        ),
                                        gapWe15,
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("مرام"),
                                            Text("maram@gmail.com")
                                          ],
                                        )
                                      ],
                                    ),
                                    gapH20,
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: lightbrownColor),
                                      child: TabBar(
                                        onTap: (value) {
                                          print("object");
                                        },
                                        // indicatorSize: TabBarIndicatorSize.values[2],
                                        indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            gradient: RadialGradient(colors: [
                                              whiteColor,
                                              whiteColor
                                            ])),
                                        tabs: [
                                          Tab(
                                            icon: SizedBox(
                                              width: 80,
                                              child: Image.asset(
                                                'assets/images/person_icon.png',
                                                height: 20,
                                                width: 45,
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            icon: SizedBox(
                                              width: 80,
                                              child: Image.asset(
                                                'assets/images/oui_users.png',
                                                height: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    gapH20,
                                    Expanded(
                                      child: TabBarView(children: [
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditPageCustomer(
                                                                          name:
                                                                              state.name,
                                                                          email:
                                                                              state.email,
                                                                          phone:
                                                                              state.phone,
                                                                        )));
                                                      },
                                                      icon: Image.asset(
                                                        'assets/images/edit.png',
                                                        width: 18,
                                                      )),
                                                ],
                                              ),
                                              InformationRowCustomer(
                                                icon: Image.asset(
                                                  'assets/images/person_icon.png',
                                                  height: 20,
                                                  width: 45,
                                                ),
                                                info: state.name ?? '',
                                              ),
                                              gapH15,
                                              InformationRowCustomer(
                                                icon: const Icon(
                                                    Icons.phone_outlined),
                                                info: state.phone.toString() ??
                                                    '',
                                              ),
                                              gapH15,
                                              InformationRowCustomer(
                                                icon: const Icon(
                                                    Icons.email_outlined),
                                                info: state.email ?? '',
                                              ),
                                              gapH60,
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 1,
                                                      blurRadius: 2,
                                                      offset:
                                                          const Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 65,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: whiteColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          spreadRadius: 1,
                                                          blurRadius: 2,
                                                          offset: const Offset(
                                                              0, 4),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text("تسجيل الخروج",
                                                                style: TextStyle(
                                                                    color: red))
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const Text("المتابعون"),
                                              FollowresRow(
                                                  name:
                                                      "شركة بناء للمقاولات والإستثمار",
                                                  path:
                                                      'assets/images/benaa_cpmpany.png'),
                                              gapH20,
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ],
                                )))),
                  );
                } else if (state is ProfileLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(
                    child: Text("Error"),
                  );
                }
              },
            );
          }),
        ));
  }
}
