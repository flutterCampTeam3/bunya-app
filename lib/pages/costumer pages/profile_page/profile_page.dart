// import 'package:bunya_app/data/model/offices_model.dart';
// import 'package:bunya_app/data/service/supabase_services.dart';
// import 'package:bunya_app/helper/colors.dart';
// import 'package:bunya_app/helper/extintion.dart';
// import 'package:bunya_app/helper/sized.dart';
// import 'package:bunya_app/pages/Office%20pages/office%20auth%20pages/signIn%20page/signin_page.dart';
// import 'package:bunya_app/pages/costumer%20pages/profile_page/bloc/profile_bloc.dart';
// import 'package:bunya_app/pages/costumer%20pages/profile_page/edit_page.dart';
// import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/follower_widget.dart';
// import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/image_aacount_widget.dart';
// import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/information_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';

// import '../../../data/model/office_follow_model.dart';

// class ProfilePageCustomer extends StatelessWidget {
//   ProfilePageCustomer({super.key, this.follow});

//   @override
//   final locator = GetIt.I.get<DBService>();
//   final OfficesModel? follow;
//   // bool isEditing = false;
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         initialIndex: 0,
//         length: 2,
//         child: BlocProvider(
//           create: (context) => ProfileBloc(),
//           child: Builder(builder: (context) {
//             final bloc = context.read<ProfileBloc>();
//             bloc.add(GetUserInfoEvent());
//             // bloc.add(ShowFloowersEvent());
//             return BlocBuilder<ProfileBloc, ProfileState>(
//               builder: (context, state) {
//                 if (state is DisplayUserInfoState ) {
//                   return Directionality(
//                     textDirection: TextDirection.rtl,
//                     child: Scaffold(
//                         // backgroundColor: whiteColor,
//                         body: SafeArea(
//                             child: Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 child: Column(
//                                   children: [
//                                     const Align(
//                                         alignment: Alignment.centerRight,
//                                         child: Text(
//                                           "حسابي",
//                                           style: TextStyle(fontSize: 24),
//                                         )),
//                                     gapH10,
//                                     Row(
//                                       children: [
//                                         ImageAacountWodget(
//                                           path: state.image!,
//                                         ),
//                                         gapWe15,
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(state.name!),
//                                             Text(state.email!)
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                     gapH20,
//                                     Container(
//                                       padding: const EdgeInsets.all(2),
//                                       height: 40,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                           color: lightbrownColor),
//                                       child: TabBar(
//                                         onTap: (value) {
//                                           print("object");
//                                         },
//                                         dividerColor: transparent,
//                                         // indicatorSize: TabBarIndicatorSize.values[2],
//                                         indicator: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(30),
//                                             gradient: RadialGradient(colors: [
//                                               whiteColor,
//                                               whiteColor
//                                             ])),
//                                         tabs: [
//                                           Tab(
//                                             icon: SizedBox(
//                                               width: 80,
//                                               child: Image.asset(
//                                                 'assets/images/person_icon.png',
//                                                 height: 20,
//                                                 width: 45,
//                                               ),
//                                             ),
//                                           ),
//                                           Tab(
//                                             icon: SizedBox(
//                                               width: 80,
//                                               child: Image.asset(
//                                                 'assets/images/oui_users.png',
//                                                 height: 20,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     gapH20,
//                                     Expanded(
//                                       child: TabBarView(children: [
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.end,
//                                                 children: [
//                                                   IconButton(
//                                                       onPressed: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder:
//                                                                     (context) =>
//                                                                         EditPageCustomer(
//                                                                           name:
//                                                                               state.name!,
//                                                                           email:
//                                                                               state.email!,
//                                                                           phone:
//                                                                               state.phone!,
//                                                                           image:
//                                                                               state.image!,
//                                                                         ))).then(
//                                                             (value) {
//                                                           bloc.add(
//                                                               GetUserInfoEvent());
//                                                         });
//                                                       },
//                                                       icon: Image.asset(
//                                                         'assets/images/edit.png',
//                                                         color: Theme.of(context)
//                                                             .colorScheme
//                                                             .surface,
//                                                         width: 18,
//                                                       )),
//                                                 ],
//                                               ),
//                                               InformationRowCustomer(
//                                                 icon: Image.asset(
//                                                   'assets/images/person_icon.png',
//                                                   height: 20,
//                                                   width: 45,
//                                                 ),
//                                                 info: state.name ?? '',
//                                               ),
//                                               gapH15,
//                                               InformationRowCustomer(
//                                                 icon: const Icon(
//                                                   Icons.phone_outlined,
//                                                   color: Colors.black,
//                                                 ),
//                                                 info: state.phone.toString() ??
//                                                     '',
//                                               ),
//                                               gapH15,
//                                               InformationRowCustomer(
//                                                 icon: const Icon(
//                                                   Icons.email_outlined,
//                                                   color: Colors.black,
//                                                 ),
//                                                 info: state.email ?? '',
//                                               ),
//                                               gapH60,
//                                               Container(
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(15),
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                       color: Colors.grey
//                                                           .withOpacity(0.3),
//                                                       spreadRadius: 1,
//                                                       blurRadius: 2,
//                                                       offset:
//                                                           const Offset(0, 4),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 child: InkWell(
//                                                   onTap: () async {
//                                                     await locator.signOut();
//                                                     context.pushAndRemove(
//                                                         const SigninPage());
//                                                   },
//                                                   child: Container(
//                                                     height: 65,
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15),
//                                                       color: Theme.of(context)
//                                                           .colorScheme
//                                                           .surface,
//                                                       boxShadow: [
//                                                         BoxShadow(
//                                                           color: Colors.grey
//                                                               .withOpacity(0.3),
//                                                           spreadRadius: 1,
//                                                           blurRadius: 2,
//                                                           offset: const Offset(
//                                                               0, 4),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(10.0),
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .center,
//                                                           children: [
//                                                             Text("تسجيل الخروج",
//                                                                 style: TextStyle(
//                                                                     color: red))
//                                                           ],
//                                                         )),
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: [
//                                               const Text("المتابعون"),

//                                               // BlocConsumer<ProfileBloc,
//                                               //     ProfileState>(
//                                               //   listener: (context, state) {
//                                               //     if (state
//                                               //         is ProfileErrorState) {
//                                               //       context.showErrorSnackBar(
//                                               //           context, state.msg);
//                                               //     }
//                                               //   },
//                                               //   builder: (context, state) {

//                                               //     if (
//                                               //        bloc.classFollowing.isNotEmpty) {

//                                                     // return

//                                                     //  ListView.builder(
//                                                     //   itemCount: bloc.classFollowing.length
//                                                     //       ,
//                                                     //   itemBuilder:
//                                                     //       (context, index) {
//                                                     //     FollowresRow(
//                                                     //         path: bloc.classFollowing[index],
//                                                     //         name:bloc.classFollowing[
//                                                     //             index]);

//                                                     //   },
//                                                     // ),

//                                               //
//                                               //else {
//                                               //       return const SizedBox(
//                                               //         child: Center(
//                                               //           child:
//                                               //           Text("")),
//                                               //       );
//                                               //     }
//                                               //   },
//                                               // )

//                                               FollowresRow(
//                                                   name:
//                                                       "شركة بناء للمقاولات والإستثمار",
//                                                   path:
//                                                       'assets/images/benaa_cpmpany.png'),
//                                               gapH20,
//                                             ],
//                                           ),
//                                         ),
//                                       ]),
//                                     ),
//                                   ],
//                                 )))),
//                   );
//                 } else if (state is ProfileLoadingState) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else {
//                   // context.showErrorSnackBar(context, "حصل خطا");
//                   return const Center(
//                     child: Text("Error"),
//                   );
//                 }
//               },
//             );
//           }),
//         ));
//   }
// }

import 'package:bunya_app/data/model/offices_model.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Office%20pages/office%20auth%20pages/signIn%20page/signin_page.dart';
import 'package:bunya_app/pages/costumer%20pages/office%20profile%20pages/profile_office.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/bloc/profile_bloc.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/edit_page.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/follower_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/image_aacount_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/information_widget.dart';
import 'package:bunya_app/pages/intro%20pages/first_intro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../data/model/office_follow_model.dart';

class ProfilePageCustomer extends StatelessWidget {
  ProfilePageCustomer({super.key, this.follow});

  @override
  final locator = GetIt.I.get<DBService>();
  final OfficesModel? follow;
  // bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: BlocProvider(
          create: (context) => ProfileBloc(),
          // ..add(ShowFloowersEvent()),
          child: Builder(builder: (context) {
            final bloc = context.read<ProfileBloc>();
            bloc.add(GetUserInfoEvent());
            // bloc.add(ShowFloowersEvent());
            return BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is DisplayUserInfoState) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                        // backgroundColor: whiteColor,
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
                                          path: state.image,
                                        ),
                                        gapWe15,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(state.name),
                                            Text(state.email)
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
                                        dividerColor: transparent,
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
                                                                          image:
                                                                              state.image,
                                                                        ))).then(
                                                            (value) {
                                                          bloc.add(
                                                              GetUserInfoEvent());
                                                        });
                                                      },
                                                      icon: Image.asset(
                                                        'assets/images/edit.png',
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface,
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
                                                  Icons.phone_outlined,
                                                  color: Colors.black,
                                                ),
                                                info: state.phone.toString() ??
                                                    '',
                                              ),
                                              gapH15,
                                              InformationRowCustomer(
                                                icon: const Icon(
                                                  Icons.email_outlined,
                                                  color: Colors.black,
                                                ),
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
                                                  onTap: () async {
                                                    await locator.signOut();
                                                    context.pushAndRemove(
                                                        const introPage());
                                                  },
                                                  child: Container(
                                                    height: 65,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface,
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

                                              // BlocConsumer<ProfileBloc,
                                              //     ProfileState>(
                                              //   listener: (context, state) {
                                              //     if (state
                                              //         is ProfileErrorState) {
                                              //       context.showErrorSnackBar(
                                              //           context, state.msg);
                                              //     }
                                              //   },
                                              //   builder: (context, state) {

                                              //     if (
                                              //        bloc.classFollowing.isNotEmpty) {
                                              //       return ListView.builder(
                                              //         itemCount: bloc.classFollowing.length
                                              //             ,
                                              //         itemBuilder:
                                              //             (context, index) {
                                              //           FollowresRow(
                                              //               path: bloc.classFollowing[
                                              //                   index],
                                              //               name:bloc.classFollowing[
                                              //                   index]);
                                              //           return null;
                                              //         },
                                              //       );
                                              //     } else {
                                              //       return const SizedBox(
                                              //         child: Center(
                                              //           child:
                                              //           Text("")),
                                              //       );
                                              //     }
                                              //   },
                                              // )

                                              BlocBuilder<ProfileBloc,
                                                  ProfileState>(
                                                builder: (context, state) {
                                                  if (bloc.classFollowing
                                                      .isNotEmpty) {
                                                    return ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: bloc
                                                          .classFollowing
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              context.pushTo(
                                                                  view:
                                                                      ProfilePageOfficeCustomur(
                                                                office:
                                                                    bloc.classFollowing[
                                                                        index],
                                                              ));
                                                            },
                                                            child: FollowresRow(
                                                              name:
                                                                  bloc.classFollowing[
                                                                      index],
                                                              path:
                                                                  bloc.classFollowing[
                                                                      index],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    return const Center(
                                                      child: Text(
                                                          "لايوجد لديك متابعون "),
                                                    );
                                                  }
                                                },
                                              ),

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
                  // context.showErrorSnackBar(context, "حصل خطا");
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
