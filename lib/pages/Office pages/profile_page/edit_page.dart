import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/widgets/widgets/info_edit_row.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/image_aacount_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditPageOffice extends StatelessWidget {
  EditPageOffice({super.key});
  TextEditingController infoController = TextEditingController(
      text:
          "شركة بناء للمقاولات لديها خبرة واسعه في مجال المقاولات تمتد الي اكثر من عشرون عاما ");
  TextEditingController phoneController =
      TextEditingController(text: "053445522");
  TextEditingController emailController =
      TextEditingController(text: "akjnbsjwbec@gmail.com");
  TextEditingController addressController =
      TextEditingController(text: "الرياض ، شارع احمد");
  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 20),
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
                            child: const Icon(Icons.camera_alt_outlined),
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
              EditInfoRow(controller: phoneController, title: "الجوال:"),
              EditInfoRow(controller: emailController, title: "الايميل:"),
              EditInfoRow(controller: addressController, title: "العنوان:"),
              const Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: brownColor,
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () {},
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
  }
}

// class EditInfoRow extends StatelessWidget {
//   EditInfoRow({super.key, required this.infoController, required this.title});
//   String title;

//   final TextEditingController infoController;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 15.0),
//           child: Text(title),
//         ),
//         Expanded(
//           child: TextField(
//             style: TextStyle(color: darkGreyColor),
//             maxLines: null,
//             controller: infoController,
//           ),
//         )
//       ],
//     );
//   }
// }