import 'package:bunya_app/helper/extintion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../helper/colors.dart';
import 'chat.dart';

class FirstChatPage extends StatelessWidget {
  const FirstChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: frewhiteBrown.withOpacity(0.12),
            leading: IconButton(
                onPressed: () {
                  context.popNav();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
          ),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [frewhiteBrown, whiteBrown],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        bottom: -23,
                        child: SvgPicture.asset(
                          'assets/images/line.png',
                          width: 180,
                          color: white,
                        ),
                      ),
                      Positioned(
                        bottom: -15,
                        child: Image.asset(
                          'assets/images/bot1.png',
                          width: 300,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  '           أنا بنية\nكيف يمكنني مساعدتك؟',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    context.pushTo(view: const Chat());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    side: BorderSide.none,
                    fixedSize: const Size(200, 50),
                  ),
                  child: Image.asset(
                    'assets/images/Vector.png',
                    width: 50,
                    height: 30,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'انقر للتحدث',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
