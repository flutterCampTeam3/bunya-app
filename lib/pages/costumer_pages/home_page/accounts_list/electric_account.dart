import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/widgets/account_list_Widget.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/widgets/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ElectricAccountList extends StatelessWidget {
  const ElectricAccountList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                    const AppBarWidget(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          gapH20,
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                " حسابات الكهرباء",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          gapH10,
                          SizedBox(
                            height: 800,
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                AccountListWidget(
                                  path: 'assets/images/benaa_cpmpany.png',
                                  title: "شركة بناء للمقاولات والإستثمار",
                                  description:
                                      "شركة تعمل في مجال البناء والتشييد\n والاستثمار في المشاريع العقارية.",
                                  rate: 5,
                                  followers: 200,
                                  onTap: () {
                                    
                                  },
                                ),
                                gapWe20,
                                gapH10,
                                AccountListWidget(
                                  path: 'assets/images/mabany.png',
                                  title: "شركة مباني الرياض للمقاولات العامة",
                                  description:
                                      "شركة تعمل في مجال البناء والتشييد \nوالاستثمار في المشاريع العقارية.",
                                  rate: 4,
                                  followers: 2,
                                  onTap: () {
                                    
                                  },
                                ),
                                gapWe20,
                                gapH10,
                                AccountListWidget(
                                  path: 'assets/images/mabany.png',
                                  title: "شركة مباني الرياض للمقاولات العامة",
                                  description:
                                      "شركة تعمل في مجال البناء والتشييد \nوالاستثمار في المشاريع العقارية.",
                                  rate: 4,
                                  followers: 2,
                                  onTap: () {
                                    
                                  },
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
