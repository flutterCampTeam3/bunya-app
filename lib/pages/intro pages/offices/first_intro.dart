import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/pages/Office%20pages/office%20auth%20pages/signIn%20page/signin_page.dart';
import 'package:bunya_app/pages/intro%20pages/offices/second_intro.dart';
import 'package:flutter/material.dart';

class firstOficceIntro extends StatelessWidget {
  const firstOficceIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [whiteColor, whiteColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/images/introv3.png"),
                const Positioned(
                  top: 480,
                  left: 0,
                  right: 0,
                  child: Text(
                    " حياك ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      // Define text style here if needed
                    ),
                  ),
                ),
                const Positioned(
                  top: 530,
                  left: 0,
                  right: 0,
                  child: Text(
                    '  سجل شركتك الآن لتكون جزءًا من \nتطبيقنا الذي يوفر للعملاء فرصة \nاختيار أفضل الشركات لبناء منازلهم ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      // Define text style here if needed
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      Image.asset("assets/images/image1.png"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),

            //-------- back and next butten
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    // Add your logic here for the first clickable text
                    context.pushAndRemove(const SigninPage());
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      'تخطي',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Add icon here
                Image.asset(
                  'assets/images/PF.png',
                  width: 50,
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    context.pushAndRemove(const secondOficceIntro());
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      ' التالي',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
