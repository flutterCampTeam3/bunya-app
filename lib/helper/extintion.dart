import 'dart:async';

import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';

extension Screen on BuildContext {
  getWidth() {
    return MediaQuery.of(this).size.width;
  }

  getHeight() {
    return MediaQuery.of(this).size.height;
  }

  pushTo({required Widget view, Function(dynamic)? onValue}) {
    return Navigator.of(this)
        .push(MaterialPageRoute(builder: (context) => view))
        .then(onValue ?? (value) {});
  }

 getDialog({required String content,required String imagePath}) {
  showDialog(
    context: this,
    builder: (context) {
      return AlertDialog(
        backgroundColor: freewhiteBrown,
        elevation: 0,
        content: SizedBox(
          height: 200,
          width: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 40),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );
    },
  );

   Timer(Duration(seconds: 3), () {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop();
    }
  }
  );
}

  showSuccessSnackBar(
    BuildContext context,
    String msg,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.green,
    ));
  }


  showErrorSnackBar(
    BuildContext context,
    String msg,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.red,
    ));
  }

  popNav() {
    Navigator.pop(this);
  }

  // Push and remove
  pushAndRemove(Widget screen) {
    Navigator.pushAndRemoveUntil(this,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }
}
