import 'package:bunya_app/helper/extintion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../helper/colors.dart';
import 'chat.dart';


class FirstChatPage extends StatelessWidget {
  const FirstChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: 
     Scaffold(
      
      body: Container(
        
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [freewhiteBrown, whiteBrown],
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
      'assets/images/line.svg',
      width: 180, 
      color: white,
                    ),
                  ),
                  Positioned(
                    bottom:
                        -15, 
                    child: Image.asset(
                'assets/images/bot1.png', 
                width: 300,
                      
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left:
                        context.getWidth()/18, 
                    child: Container(
                      width: context.getWidth()/4, 
                      height: 60, 
                      decoration: BoxDecoration(
                        color: whitGreyColor,
                        borderRadius:
                            BorderRadius.only(
                               topLeft: Radius.circular(12),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(1),

                               ), 
                        border:
                            Border.all(color: Colors.transparent), 
                      ),
                      child: const Center(
                        child: Text(
                          "مرحبا سعود", // Replace with your text
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                          ),
                        ),
                      ),
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
                context.pushTo(view: Chat());
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), 
                ),
                side: BorderSide.none, 
                fixedSize: Size(200, 50), 
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