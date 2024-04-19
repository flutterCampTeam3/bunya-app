import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/costumer%20pages/accounts_list/bloc/account_list_bloc.dart';
import 'package:bunya_app/pages/costumer%20pages/accounts_list/widgets/appBar_accounts_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/home_page.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/widgets/account_list_Widget.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/widgets/appbar_widget.dart';

import 'package:bunya_app/pages/costumer%20pages/office%20profile%20pages/profile_office.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ConstraintAccountList extends StatelessWidget {
  ConstraintAccountList({super.key, required this.type});
  final String type;
  final locator = GetIt.I.get<DBService>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => AccountListBloc(),
        child: Builder(builder: (context) {
          final bloc = context.read<AccountListBloc>();
          print("BEFORE");
          bloc.add(GetAccountEvent(type: type));
          return Scaffold(
            body: Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/introv4.png', // Your image path
                    // fit: BoxFit.cover,
                  ),
                ),
                SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        const AppBarAccoutWidget(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              gapH20,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    " حسابات $type",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              gapH10,
                              BlocConsumer<AccountListBloc, AccountListState>(
                                listener: (context, state) {
                                  if (state is LoadingHomeState) {
                                    showDialog(
                                        barrierDismissible: false,
                                        barrierColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                            content: SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: brown,
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  }

                                  if (state is SuccessHomeState) {
                                    Navigator.pop(context);
                                  }
                                  if (state is ErrorHomeState) {
                                    Navigator.pop(context);
                                    context.showErrorSnackBar(
                                        context, state.msg);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is SuccessHomeState) {
                                    if (state.officeAccounte.isNotEmpty) {
                                      return SizedBox(
                                        height: context.getHeight() * 0.80,
                                        width: context.getWidth(),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              state.officeAccounte.length,
                                          itemBuilder: (context, index) {
                                            final med =
                                                state.officeAccounte[index];
                                            return AccountListWidget(
                                              path: med.image,
                                              title: med.name,
                                              description: med.disc,
                                              //rate: 5,
                                              followers: 200,
                                              onTap: () {
                                                context.pushTo(
                                                  view:
                                                      ProfilePageOfficeCustomur(
                                                    office: med,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    } else {
                                      return SizedBox(
                                        width: context.getWidth(),
                                        height: context.getHeight(),
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "لا يوجد حسابات لهذا القسم",
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  } else {
                                    return sizedBoxEmpty;
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
