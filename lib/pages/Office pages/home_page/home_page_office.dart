import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Office%20pages/home_page/widgets/post_widget.dart';
import 'package:bunya_app/pages/Office%20pages/office%20profile%20pages/profile_office.dart';
import 'package:bunya_app/pages/costumer%20pages/accounts_list/account_list.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/widgets/accounts_home_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/widgets/image_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../costumer pages/office profile pages/profile_office.dart';
import '../../postPage/post_page.dart';
import '../../costumer pages/home_page/widgets/scaffoldWidget.dart';
import 'bloc/home_bloc.dart';

class HomePageOffice extends StatelessWidget {
  const HomePageOffice({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeOfficesBloc()..add(ShowDataOfficesEvent()),
      child: Builder(builder: (context) {
        final bloc = context.read<HomeOfficesBloc>();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ScaffoldWidget(
            hasAppBar: true,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 20.0, left: 20, top: 20),
                      child: Column(
                        children: [
                          gapH15,
                          Row(
                            children: [
                              ImageWidget(
                                onTap: () {
                                  context.pushTo(
                                      view: ConstraintAccountList(
                                    type: "التصميم الداخلي",
                                  ));
                                },
                                title: "التصميم الداخلي",
                                path: 'assets/images/intern_design.jpeg',
                              ),
                              gapWe15,
                              ImageWidget(
                                onTap: () {
                                  context.pushTo(
                                      view: ConstraintAccountList(
                                    type: 'ادوات البناء',
                                  ));
                                },
                                title: "ادوات البناء",
                                path: 'assets/images/drell.jpeg',
                              ),
                            ],
                          ),
                          gapH10,
                          Row(
                            children: [
                              ImageWidget(
                                onTap: () {
                                  context.pushTo(
                                      view: ConstraintAccountList(
                                          type: "مكاتب المقاولات"));
                                },
                                title: "مكاتب المقاولات",
                                path: 'assets/images/house.jpeg',
                              ),
                              gapWe15,
                              ImageWidget(
                                onTap: () {
                                  context.pushTo(
                                      view: ConstraintAccountList(
                                    type: 'الكهرباء',
                                  ));
                                },
                                title: "الكهرباء",
                                path: 'assets/images/electric.jpeg',
                              ),
                            ],
                          ),
                          gapH20,
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "اشهر الحسابات",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          gapH10,
                          BlocConsumer<HomeOfficesBloc, HomeOfficesState>(
                            listener: (context, state) {
                              if (state is ErrorOfficesState) {
                                context.showErrorSnackBar(context, state.msg);
                              }
                            },
                            builder: (context, state) {
                              if (state is LoadingState) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: brown,
                                  ),
                                );
                              } else if (bloc.officeList.isNotEmpty) {
                                // Return ListView.builder when the state is postsLoadedState
                                return SizedBox(
                                  height: 100,
                                  width: context.getWidth(),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 6,
                                    // bloc.officeList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          context.pushTo(
                                              view: ProfilePageOfficeOffice(
                                            office: bloc.officeList[index],
                                          ));
                                        },
                                        child: AccountsHomeWidget(
                                          description: bloc.officeList[index],
                                          path: bloc.officeList[index],
                                          title: bloc.officeList[index],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                // Return an empty SizedBox for other states
                                return const SizedBox();
                              }
                            },
                          ),
                          gapH10,
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "اكتشف",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          gapH10,
                          BlocConsumer<HomeOfficesBloc, HomeOfficesState>(
                            listener: (context, state) {
                              if (state is ErrorOfficesState) {
                                Navigator.pop(context);
                                context.showErrorSnackBar(context, state.msg);
                              }
                            },
                            builder: (context, state) {
                              // if (state is LoadingState) {
                              //   return Center(
                              //     child: CircularProgressIndicator(
                              //       color: darkBrown,
                              //     ),
                              //   );
                              // } else
                              if (bloc.classPost.isNotEmpty) {
                                // Return GridView when the state is postsLoadedState
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio: 0.75,
                                  ),
                                  itemCount: bloc.classPost.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        context
                                            .pushTo(
                                                view: PostPage(
                                                    post: bloc.classPost[index],
                                                    office:
                                                        bloc.officeList[index]))
                                            .then((_) {
                                          bloc.add(ShowDataOfficesEvent());
                                        });
                                      },
                                      child: PostOfficeHomeWidget(
                                        postPath: bloc.classPost[index],
                                        description: bloc.classPost[index],
                                        profilePath: bloc.officeList[index],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                // Return an empty SizedBox for other states
                                return const SizedBox();
                              }
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
