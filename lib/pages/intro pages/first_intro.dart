import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/pages/intro%20pages/customer/onboarding_screen.dart';
import 'package:flutter/material.dart';

class introPage extends StatelessWidget {
  const introPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [whiteColor, whiteColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/images/introv1.png"),
                const Positioned(
                  top: 480,
                  left: 0,
                  right: 0,
                  child: Text(
                    'اهلا بك ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold
                        // Define text style here if needed
                        ),
                  ),
                ),
                const Positioned(
                  top: 550,
                  left: 0,
                  right: 0,
                  child: Text(
                    'صاحب شركة ام تريد بناء منزل؟',
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
                      Image.asset("assets/images/Fimage.png"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.pushAndRemove(BoardingPage());
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(lightBrown),
                    fixedSize:
                        WidgetStateProperty.all<Size>(const Size(150, 50)),
                  ),
                  // style: ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.all<Color>(lightBrown),
                  //   fixedSize:
                  //       MaterialStateProperty.all<Size>(const Size(150, 50)),
                  // ),
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
                    context.pushAndRemove(BoardingPage(
                      isCustomer: false,
                    ));
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(lightBrown),
                    fixedSize:
                        WidgetStateProperty.all<Size>(const Size(150, 50)),
                  ),

                  // style: ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.all<Color>(lightBrown),
                  //   fixedSize:
                  //       MaterialStateProperty.all<Size>(const Size(150, 50)),
                  // ),
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
          ],
        ),
      ),
    );
  }
}
