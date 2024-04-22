import 'dart:async';

import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/pages/costumer%20pages/office%20profile%20pages/profile_office.dart';
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

  getDialog() {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: this,
        builder: (context) {
          return SizedBox(
            height: 80,
            width: 80,
            child: Center(
              child: CircularProgressIndicator(
                color: brown,
              ),
            ),
          );
        });
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
