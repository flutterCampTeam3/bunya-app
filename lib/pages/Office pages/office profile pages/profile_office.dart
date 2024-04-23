import 'package:bunya_app/data/model/offices_model.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Office%20pages/office%20profile%20pages/bloc/office_office_bloc.dart';
import 'package:bunya_app/pages/Office%20pages/office%20profile%20pages/widgets/app_par_prof_office.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/widgets/widgets/information_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/chat_page/chat_page.dart';
import 'package:bunya_app/pages/costumer%20pages/office%20profile%20pages/bloc/profile_posts_bloc.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/image_aacount_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePageOfficeOffice extends StatelessWidget {
  const ProfilePageOfficeOffice({super.key, required this.office});
  final OfficesModel office;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OfficeOfficeBloc()
        ..add(ShowDataIdOfficeEvent(id: office.officeId))
        ..add(CheckFollowNumberOfficeEvent(
          officeId: office.officeId,
        )),
      child: Builder(builder: (context) {
        final bloc = context.read<OfficeOfficeBloc>();
        bloc.add(CheckFollowOfficeEvent(id: office.officeId));
        return Directionality(
            textDirection: TextDirection.rtl,
            child: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Scaffold(
                // backgroundColor: whiteColor,
                body: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    children: [
                      const AppBarOfficeOfficeWidget(),
                      gapH5,
                      Row(
                        children: [
                          ImageAacountWodget(
                            path: office.image,
                          ),
                          gapWe15,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(office.name), Text(office.email)],
                          )
                        ],
                      ),
                      BlocBuilder<OfficeOfficeBloc, OfficeOfficeState>(
                        builder: (context, state) {
                          return IntrinsicHeight(
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
                                      Theme.of(context).colorScheme.secondary,
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
                                  color: blackColor,
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
                          );
                        },
                      ),
                      gapH20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                               bloc.add(
                                  CheckRoomOfficeEvent(officeId: office.officeId));
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(lightBrown),
                              fixedSize: WidgetStateProperty.all<Size>(
                                  const Size(130, 50)),
                            ),
                          
                            // style: ButtonStyle(
                            //   backgroundColor:
                            //       MaterialStateProperty.all<Color>(lightBrown),
                            //   fixedSize: MaterialStateProperty.all<Size>(
                            //       const Size(150, 50)),
                            // ),
                            child: const Text(
                              'محادثة',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          BlocConsumer<OfficeOfficeBloc, OfficeOfficeState>(
                            listener: (context, state) {
                              if (state is ErrorFollowOfficeState) {
                                context.showErrorSnackBar(context, state.msg);
                              }
                              if (state is CheckChatOfficeState) {
                                context.pushTo(
                                    view: ChatView(room: state.room));
                              }
                            },
                            builder: (context, state) {
                              if (state is LoadingOfficeState) {
                                return SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: brown,
                                    ),
                                  ),
                                );
                              } else {
                                return Row(
                                  children: [
                                    Visibility(
                                      visible: bloc.isFollow,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          bloc.add(DeleteFollowOfficeEvent(
                                              id: office.officeId));
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  lightBrown),
                                          fixedSize:
                                              WidgetStateProperty.all<Size>(
                                                  const Size(130, 50)),
                                        ),
                                        // style: ButtonStyle(
                                        //   backgroundColor:
                                        //       MaterialStateProperty.all<Color>(
                                        //           lightBrown),
                                        //   fixedSize:
                                        //       WidgetStateProperty.all<Size>(
                                        //           const Size(130, 50)),
                                        // ),
                                        
                                        child: const Text(
                                          'الغاء المتابعة ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: !bloc.isFollow,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print("press the add bottun");
                                          bloc.add(AddFollowOfficeEvent(
                                              id: office.officeId));
                                        },
                                       style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  lightBrown),
                                          fixedSize:
                                              MaterialStateProperty.all<Size>(
                                                  const Size(150, 50)),
                                        ),
                                        // style: ButtonStyle(
                                        //   backgroundColor:
                                        //       WidgetStateProperty.all<Color>(
                                        //           brown),
                                        //   fixedSize:
                                        //       WidgetStateProperty.all<Size>(
                                        //           const Size(130, 50)),
                                        // ),
                                        
                                        child: const Text(
                                          'متابعة',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      gapH20,
                      // gapH20,
                      Container(
                        padding: const EdgeInsets.all(2),
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: lightbrownColor),
                        child: TabBar(
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
                                InformationWidgetOffice(
                                  widget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "معلومات الشركة :",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      gapH5,
                                      Text(
                                        office.disc,
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black),
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
                                      const Text(
                                        "معلومات التواصل :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      gapH5,
                                      Text(
                                        office.email,
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                      Text(
                                        office.phoneNumber.toString(),
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                      Text(
                                        office.name,
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BlocConsumer<OfficeOfficeBloc, OfficeOfficeState>(
                            listener: (context, state) {
                              if (state is ErrorprofileShowpostOfficeState) {
                                // Navigator.pop(context);
                                context.showErrorSnackBar(context, state.msg);
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
                                        return PostProfileWidget(
                                          desc: bloc.classPostId[index],
                                          path: bloc.classPostId[index],
                                        );
                                      }),
                                );
                              } else {
                                return const SizedBox(
                                  child: Center(
                                      child: Text("لا يوجد منشورات حتى الان")),
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
            ));
      }),
    );
  }
}
