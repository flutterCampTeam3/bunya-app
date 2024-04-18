import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/bloc/profile_office_bloc.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/profile_Office_pagee.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/widgets/widgets/info_edit_row.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/bloc/profile_bloc.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/image_aacount_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class EditPageOffice extends StatelessWidget {
  EditPageOffice(
      {super.key,
      required this.name,
      required this.email,
      required this.phone,
      required this.desc});
  final locator = GetIt.I.get<DBService>();

  String name;
  String email;
  String desc;
  int phone;
  TextEditingController infoController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    emailController.text = email;
    infoController.text = name;
    descController.text = desc;
    phoneController.text = phone.toString();
    return BlocProvider(
      create: (context) => ProfileOfficeBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<ProfileOfficeBloc>();
        return BlocConsumer<ProfileOfficeBloc, ProfileOfficeState>(
          listener: (context, state) {
            if (state is ProfilOfficeSuccessState) {
              context.showSuccessSnackBar(context, state.msg);
              context.pushAndRemove(ProfilePageOffice());
              // bloc.add(GetUserInfoEvent());
            }
            if (state is ProfileOfficeErrorState) {
              context.showErrorSnackBar(context, state.msg);
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_outlined)),
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "تعديل حسابي",
                            style: TextStyle(fontSize: 24),
                          )),
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            ImageAacountWodget(
                              path: 'assets/images/benaa_cpmpany.png',
                            ),
                            Positioned(
                                bottom: 0,
                                child: InkWell(
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: greyColor),
                                    child:
                                        const Icon(Icons.camera_alt_outlined),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      gapH20,
                      EditInfoRow(
                        controller: infoController,
                        title: "معلومات\n الشركة :",
                      ),
                      EditInfoRow(
                          controller: phoneController, title: "الجوال:"),
                      EditInfoRow(
                          controller: emailController, title: "الايميل:"),
                      // EditInfoRow(
                      //     controller: descController, title: "العنوان:"),
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: brownColor,
                              minimumSize: const Size(double.infinity, 50)),
                          onPressed: () async {
                            await locator.editUpdateOffice(
                                name: infoController.text,
                                email: emailController.text,
                                phone: int.parse(phoneController.text),
                                description: descController.text);
                            Navigator.pop(context);
                            // bloc.add(UpdateOfficeInfoEvent(
                            //     name: infoController.text,
                            //     email: emailController.text,
                            //     phone: int.parse(phoneController.text),
                            //     description: descController.text));
                          },
                          child: Text(
                            "حفظ",
                            style: TextStyle(
                                color: whiteColor, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
