import 'package:bunya_app/data/model/offices_model.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Office%20pages/home_page/bloc/home_bloc.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/bloc/profile_office_bloc.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/edit_office_page.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/widgets/widgets/information_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/image_aacount_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfilePageOffice extends StatelessWidget {
  ProfilePageOffice({super.key, this.officeId});
  final OfficesModel? officeId;
  @override
  final locator = GetIt.I.get<DBService>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: BlocProvider(
        create: (context) => ProfileOfficeBloc(),
        child: Builder(builder: (context) {
          final bloc = context.read<ProfileOfficeBloc>();
          // ..add(ShowDataOfficesIdEvent(id:officeId!.officeId ));
          // bloc.add(GetOfficeInfoEvent());
           bloc.add(ShowDataOfficesIdEvent(id: officeId!.officeId));
          return BlocBuilder<ProfileOfficeBloc, ProfileOfficeState>(
            builder: (context, state) {
              if (state is DisplayOfficeInfoState) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                    backgroundColor: whiteColor,
                    body: SafeArea(
                        child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ImageAacountWodget(
                                path: state.image,
                              ),
                              gapWe15,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(state.name), Text(state.email)],
                              )
                            ],
                          ),
                          gapH20,
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Column(
                                  children: [
                                    Text("التقييم"),
                                    gapH20,
                                    Text("4/5"),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 30.0,
                                  thickness: 1.0,
                                  color: blackColor,
                                ),
                                const Column(
                                  children: [
                                    Text("المتابَعون"),
                                    gapH20,
                                    Text("500"),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 30.0,
                                  thickness: 1.0,
                                  color: blackColor,
                                ),
                                const Column(
                                  children: [
                                    Text("المتابِعون"),
                                    gapH20,
                                    Text("90"),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 30.0,
                                  thickness: 1.0,
                                  color: blackColor,
                                ),
                                const Column(
                                  children: [
                                    Text("الإعجابات"),
                                    gapH20,
                                    Text("1500"),
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
                              onTap: (value) {
                                print("object");
                              },
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
                                                          desc:
                                                              state.description,
                                                          name: state.name,
                                                          email: state.email,
                                                          phone: state.phone,
                                                        ))).then((value) {
                                              bloc.add(GetOfficeInfoEvent());
                                            });
                                          },
                                          icon: Image.asset(
                                            'assets/images/edit.png',
                                            width: 18,
                                          )),
                                    ),
                                    InformationWidgetOffice(
                                      widget: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "معلومات الشركة :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          gapH5,
                                          Text(
                                            state.name,
                                            style:
                                                const TextStyle(fontSize: 14),
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
                                                fontWeight: FontWeight.bold),
                                          ),
                                          gapH5,
                                          Text(
                                            state.email,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          Text(
                                            state.phone.toString(),
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          // const Text(
                                          //   "الموقع : الرياض -شارع فهد",
                                          //   style: TextStyle(fontSize: 14),
                                          // )
                                        ],
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
                                  if (state is profilePostsSuccesState) {
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
                                            print("inside the loob");
                                            return PostProfileWidget(
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
                              // SingleChildScrollView(
                              //   child: Column(
                              //     children: [
                              //       PostProfileWidget(
                              //         path:
                              //             "assets/images/design_category.jpeg",
                              //         name: "لاء علي",
                              //         profilePath: 'assets/images/post1.jpeg',
                              //         likes: "100 لايك",
                              //         desc:
                              //             "تصميم ديكور صالة  فاخرة  احد فنادق مدينة جدة بستايل\n مودرن حديث  ",
                              //       ),
                              //       gapH15,
                              //       PostProfileWidget(
                              //         path:
                              //             "assets/images/design_category.jpeg",
                              //         name: "لاء علي",
                              //         profilePath: 'assets/images/post1.jpeg',
                              //         likes: "100 لايك",
                              //         desc:
                              //             "تصميم ديكور صالة  فاخرة  احد فنادق مدينة جدة بستايل\n مودرن حديث  ",
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ]),
                          ),
                        ],
                      ),
                    )),
                  ),
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
      ),
    );
  }
}
