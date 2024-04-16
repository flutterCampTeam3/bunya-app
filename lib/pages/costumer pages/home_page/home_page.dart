import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/widgets/accounts_home_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/widgets/appbar_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/widgets/image_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const AppBarWidget(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    gapH15,
                    Row(
                      children: [
                        ImageWidget(
                          onTap: () {},
                          title: "التصميم الداخلي",
                          path: 'assets/images/intern_design.jpeg',
                        ),
                        gapWe15,
                        ImageWidget(
                          onTap: () {},
                          title: "ادوات البناء",
                          path: 'assets/images/drell.jpeg',
                        ),
                      ],
                    ),
                    gapH10,
                    Row(
                      children: [
                        ImageWidget(
                          onTap: () {},
                          title: "مكاتب المقاولات",
                          path: 'assets/images/house.jpeg',
                        ),
                        gapWe15,
                        ImageWidget(
                          onTap: () {},
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
                    SizedBox(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          AccountsHomeWidget(
                            path: 'assets/images/benaa_cpmpany.png',
                            title: "شركة بناء للمقاولات والإستثمار",
                            description:
                                "شركة تعمل في مجال البناء والتشييد\n والاستثمار في المشاريع العقارية.",
                          ),
                          gapWe20,
                          AccountsHomeWidget(
                            path: 'assets/images/mabany.png',
                            title: "شركة مباني الرياض للمقاولات العامة",
                            description:
                                "شركة تعمل في مجال البناء والتشييد \nوالاستثمار في المشاريع العقارية.",
                          ),
                        ],
                      ),
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
                    Row(
                      children: [
                        PostWidget(
                          postPath: 'assets/images/post1.jpeg',
                          like: "100 لايك",
                          description:
                              "تصميم داخلي شقة خاصة في احد ابراج مدينى الرياض",
                          profilePath: 'assets/images/profile1.jpeg',
                          name: "الاء علي",
                        ),
                        gapWe10,
                        PostWidget(
                          postPath: 'assets/images/post1.jpeg',
                          like: "100 لايك",
                          description:
                              "تصميم داخلي شقة خاصة في احد ابراج مدينى الرياض",
                          profilePath: 'assets/images/profile1.jpeg',
                          name: "الاء علي",
                        ),
                      ],
                    ),
                    gapH20,
                    Row(
                      children: [
                        PostWidget(
                          postPath: 'assets/images/post1.jpeg',
                          like: "100 لايك",
                          description:
                              "تصميم داخلي شقة خاصة في احد ابراج مدينى الرياض",
                          profilePath: 'assets/images/profile1.jpeg',
                          name: "الاء علي",
                        ),
                        gapWe10,
                        PostWidget(
                          postPath: 'assets/images/post1.jpeg',
                          like: "100 لايك",
                          description:
                              "تصميم داخلي شقة خاصة في احد ابراج مدينى الرياض",
                          profilePath: 'assets/images/profile1.jpeg',
                          name: "الاء علي",
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
