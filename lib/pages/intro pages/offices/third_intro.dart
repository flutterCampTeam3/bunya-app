import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';

class thirdOficceIntro extends StatelessWidget {
  const thirdOficceIntro({super.key});

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
                Image.asset("assets/images/introv2.png"),
                const Positioned(
                  top: 480,
                  left: 0,
                  right: 0,
                  child: Text(
                    " وسّع نطاق عملك وصل إلى زبائن جدد يبحثون عن شركات موثوقة في بناء المنازل  ",
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
                      Image.asset("assets/images/image3.png"),
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
                  'assets/images/PM.png',
                  width: 50,
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                   
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
