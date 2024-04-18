import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/edit_page.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/widgets/widgets/information_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/image_aacount_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/post_widget.dart';
import 'package:bunya_app/pages/intro%20pages/customer/first_intro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ProfilePageOfficeCustomur extends StatelessWidget {
  const ProfilePageOfficeCustomur({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
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
                    path: 'assets/images/benaa_cpmpany.png',
                  ),
                  gapWe15,
                  const Column(
                    children: [
                      Text("شركة بناء للمقاولات والإستثمار"),
                      Text("bnaa@gmail.com")
                    ],
                  )
                ],
              ),
              gapH20,
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(lightBrown),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(150, 50)),
                  ),
                  child: const Text(
                    'عميل',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(lightBrown),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(150, 50)),
                  ),
                  child: const Text(
                    'صاحب شركة',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
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
                      gradient:
                          RadialGradient(colors: [whiteColor, whiteColor])),
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
                                    builder: (context) {
                                      // Return the widget for the new route here
                                      return EditPageOffice();
                                    },
                                  ),
                                );
                              },
                              icon: Image.asset(
                                'assets/images/edit.png',
                                width: 18,
                              )),
                        ),
                        InformationWidgetOffice(
                          widget: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "معلومات الشركة :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              gapH5,
                              Text(
                                " شركة بناء للمقاولات لديها خبرة واسعه في مجال المقاولات تمتد الي اكثر من عشرون عاما",
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        gapH20,
                        InformationWidgetOffice(
                          widget: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "معلومات التواصل :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              gapH5,
                              Text(
                                "ايميل: bnaa@gmail.com ",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "رقم الجوال : 05677777789",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "الموقع : الرياض -شارع فهد",
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        PostProfileWidget(
                          path: "assets/images/design_category.jpeg",
                          name: "لاء علي",
                          profilePath: 'assets/images/post1.jpeg',
                          likes: "100 لايك",
                          desc:
                              "تصميم ديكور صالة  فاخرة  احد فنادق مدينة جدة بستايل\n مودرن حديث  ",
                        ),
                        gapH15,
                        PostProfileWidget(
                          path: "assets/images/design_category.jpeg",
                          name: "لاء علي",
                          profilePath: 'assets/images/post1.jpeg',
                          likes: "100 لايك",
                          desc:
                              "تصميم ديكور صالة  فاخرة  احد فنادق مدينة جدة بستايل\n مودرن حديث  ",
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        )),
      ),
    );
  }
}