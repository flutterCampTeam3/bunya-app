import 'package:bunya_app/data/service/supabase%20services/services.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/bloc/profile_office_bloc.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/edit_office_page.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/widgets/widgets/information_widget.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/widgets/widgets/post_widget%20copy.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/image_aacount_widget.dart';
import 'package:bunya_app/pages/intro%20pages/first_intro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfilePageOffice extends StatelessWidget {
  ProfilePageOffice({
    super.key,
    // required this.officeId
  });
  // final OfficesModel officeId;
  final locator = GetIt.I.get<DBService>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: BlocProvider(
        create: (context) => ProfileOfficeBloc(),
        child: Builder(builder: (context) {
          final bloc = context.read<ProfileOfficeBloc>()
            ..add(GetOfficeInfoOfficeEvent())
            ..add(ShowDataOfficesIdEvent())
            ..add(CheckFollowNumberOfOfficeEvent());
          return BlocConsumer<ProfileOfficeBloc, ProfileOfficeState>(
            listener: (context, state) {
              if (state is ProfileOfficeErrorState) {
                // Navigator.pop(context);
                context.showErrorSnackBar(context, state.msg);
              }
            },
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: brown,
                  ),
                );
              } else if (state is DisplayOfficeInfoState) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                    body: SafeArea(
                        child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ImageAacountWodget(
                                path: bloc.profile.image,
                              ),
                              gapWe15,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bloc.profile.name,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                  ),
                                  Text(bloc.profile.email)
                                ],
                              )
                            ],
                          ),
                          gapH20,
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const Text("المتابَعون"),
                                    gapH20,
                                    Text("${bloc.followerNumber}"),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 30.0,
                                  thickness: 1.0,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                Column(
                                  children: [
                                    const Text("المتابِعون"),
                                    gapH20,
                                    Text("${bloc.followingNumber}"),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 30.0,
                                  thickness: 1.0,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                Column(
                                  children: [
                                    const Text("الإعجابات"),
                                    gapH20,
                                    Text("${bloc.likesNumber}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          gapH20,
                          Container(
                            padding: const EdgeInsets.all(2),
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: lightbrownColor),
                            child: TabBar(
                              onTap: (value) {},

                              dividerColor: transparent,
                              // indicatorSize: TabBarIndicatorSize.values[2],
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: RadialGradient(
                                      colors: [whiteColor, whiteColor])),
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
                                      'assets/images/post_icon.png',
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
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPageOffice(
                                                          desc: bloc.profile
                                                              .description,
                                                          name:
                                                              bloc.profile.name,
                                                          email: bloc
                                                              .profile.email,
                                                          phone: bloc
                                                              .profile.phone,
                                                        ))).then((value) {
                                              bloc.add(
                                                  GetOfficeInfoOfficeEvent());
                                            });
                                          },
                                          icon: Image.asset(
                                              'assets/images/edit.png',
                                              width: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface)),
                                    ),
                                    InformationWidgetOffice(
                                      widget: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "معلومات الشركة :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: blackColor),
                                          ),
                                          gapH5,
                                          Text(
                                            bloc.profile.name,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: blackColor),
                                          )
                                        ],
                                      ),
                                    ),
                                    gapH20,
                                    InformationWidgetOffice(
                                      widget: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "معلومات التواصل :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: blackColor),
                                          ),
                                          gapH5,
                                          Text(
                                            bloc.profile.email,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: blackColor),
                                          ),
                                          Text(
                                            bloc.profile.phone.toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: blackColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    gapH20,
                                    InkWell(
                                      onTap: () async {
                                        await locator.signOut();
                                        context
                                            .pushAndRemove(const introPage());
                                      },
                                      child: Container(
                                        height: 65,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("تسجيل الخروج",
                                                    style:
                                                        TextStyle(color: red))
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              BlocConsumer<ProfileOfficeBloc,
                                  ProfileOfficeState>(
                                listener: (context, state) {
                                  if (state is ProfileOfficeErrorState) {
                                    // Navigator.pop(context);
                                    context.showErrorSnackBar(
                                        context, state.msg);
                                  }
                                },
                                builder: (context, state) {
                                  if (bloc.classPostId.isNotEmpty) {
                                    return SizedBox(
                                      child: GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            crossAxisSpacing: 10.0,
                                            mainAxisSpacing: 10.0,
                                            childAspectRatio: 0.75,
                                          ),
                                          itemCount: bloc.classPostId.length,
                                          itemBuilder: (context, index) {
                                            return PostProfileOfficeWidget(
                                              desc: bloc.classPostId[index],
                                              path: bloc.classPostId[index],
                                            );
                                          }),
                                    );
                                  } else {
                                    return const SizedBox(
                                      child: Center(
                                          child:
                                              Text("لا يوجد منشورات حتى الان")),
                                    );
                                  }
                                },
                              )
                            ]),
                          ),
                        ],
                      ),
                    )),
                  ),
                );
              } else {
                return const Center(
                  child: Text("Error"),
                );
              }
            },
          );
        }),
      ),
    );
  }
}
