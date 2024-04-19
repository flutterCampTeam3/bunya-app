import 'package:bunya_app/data/model/profile_model_customer.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/widgets/widgets/info_edit_row.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/bloc/profile_bloc.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/profile_page.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/image_aacount_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class EditPageCustomer extends StatelessWidget {
  EditPageCustomer(
      {super.key,
      required this.name,
      required this.email,
      required this.phone});
  final locator = GetIt.I.get<DBService>();

  TextEditingController infoController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController addressController =
  //     TextEditingController(text: "الرياض ، شارع احمد");
  String name;
  String email;
  int phone;
  @override
  Widget build(BuildContext context) {
    emailController.text = email;
    infoController.text = name;
    phoneController.text = phone.toString();

    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Builder(builder: (context) {
          final bloc = context.read<ProfileBloc>();
          return BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfilSuccessState) {
                // context.showSuccessSnackBar(context, state.msg);
                // context.pushAndRemove(ProfilePageCustomer());
                // bloc.add(GetUserInfoEvent());
              }
              if (state is ProfileErrorState) {
                context.showErrorSnackBar(context, state.msg);
              }
            },
            builder: (context, state) {
              return Scaffold(
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
                              path: 'assets/images/profile_image.png',
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
                        title: "الاسم:",
                      ),
                      EditInfoRow(
                          controller: phoneController, title: "الجوال:"),
                      EditInfoRow(
                          controller: emailController, title: "الايميل:"),
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: brownColor,
                              minimumSize: const Size(double.infinity, 50)),
                          onPressed: () async {
                            await locator.editUpdate(
                                name: infoController.text,
                                email: emailController.text,
                                phone: int.parse(phoneController.text));
                            Navigator.pop(context);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => EditPageCustomer(
                            //       name: infoController.text,
                            //       email: emailController.text,
                            //       phone: int.parse(phoneController.text),
                            //     ),
                            //   ),
                            // );
                            // .then((value) {
                            //   if (value != null && value == true) {
                            //     bloc.add(GetUserInfoEvent());
                            //   }
                            // }
                            // );

                            bloc.add(UpdateUserInfoEvent(
                                name: infoController.text,
                                email: emailController.text,
                                phone: int.parse(phoneController.text)));
                            context.showSuccessSnackBar(
                                context, "تم تغيير البيانات بنجاح");

                            // Navigator.pop(context);
                          },
                          child: Text(
                            "حفظ",
                            style: TextStyle(
                                color: whiteColor, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
