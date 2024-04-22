import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Messages_pages/widgets/message_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MessageListPage extends StatelessWidget {
  const MessageListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: white,
        body: Stack(
          children: [
            // Background Image
            /*
            Positioned.fill(
              child: Image.asset(
                'assets/images/introv4.png', // Your image path
                // fit: BoxFit.cover,
              ),
            ),
            */
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    //const AppBarWidget(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          gapH20,
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                " الرسائل",
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
                                MessageListWidget(
                                  path: 'assets/images/benaa_cpmpany.png',
                                  title:
                                      "رسالة من شركة بناء للمقاولات والإستثمار",
                                  onTap: () {},
                                  sendTime: '12:00',
                                ),
                                gapWe20,
                                gapH10,
                                MessageListWidget(
                                  path: 'assets/images/mabany.png',
                                  title: "شركة مباني الرياض للمقاولات العامة",
                                  onTap: () {},
                                  sendTime: '9:00',
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
