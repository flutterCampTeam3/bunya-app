import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/costumer_pages/home_page/widgets/account_list_Widget.dart';
import 'package:bunya_app/pages/costumer_pages/home_page/widgets/accounts_home_widget.dart';
import 'package:bunya_app/pages/costumer_pages/home_page/widgets/appbar_widget.dart';
import 'package:bunya_app/pages/costumer_pages/home_page/widgets/image_widget.dart';
import 'package:bunya_app/pages/costumer_pages/home_page/widgets/post_widget.dart';
import 'package:bunya_app/pages/intro%20pages/first_intro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class DesginAccountList extends StatelessWidget {
  const DesginAccountList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            
            Positioned.fill(
              child: Image.asset(
                'assets/images/introv4.png', 
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
                                " حسابات المصممين",
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
                                  path: 'assets/images/rasha.png',
                                  title: "رشا الحربي",
                                  description: "مصصمة ديكور   .",
                                  rate: 5,
                                  followers: 200,
                                  onTap: () {
                                    
                                  },
                                ),
                                Divider(height: 20, color: Colors.transparent),
                                AccountListWidget(
                                  path: 'assets/images/allaa.png',
                                  title: "الاء الحارثي",
                                  description: " مصممة ديكورات منازل داخلية",
                                  rate: 4,
                                  followers: 2,
                                  onTap: () {
                                    
                                  },
                                ),
                                // Add Divider here if needed
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
