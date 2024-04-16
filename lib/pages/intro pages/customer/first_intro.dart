import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/pages/intro%20pages/customer/second_intro.dart';
import 'package:flutter/material.dart';

class firstCustomerIntro extends StatelessWidget {
  const firstCustomerIntro({super.key});

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
                  top: 550,
                  left: 0,
                  right: 0,
                  child: Text(
                    '     ابدأ رحلتك بالعثور على كل\n ما تحتاجه لبناء منزلك  ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      // Define text style here if needed
                    ),
                  ),
                ),
                SizedBox(
                  height: 280,
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
                    context.pushAndRemove(secondCustomerIntro());
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
