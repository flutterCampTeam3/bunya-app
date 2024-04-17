import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';

class SignintextFieldAuth extends StatelessWidget {
   SignintextFieldAuth({
    Key? key,
    required this.Controller,
    required this.label,
    required this.obscureText,
    this.email = false,
  });
 bool obscureText =true;
  final Controller;
  String label;
  bool email;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: whiteBrown),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: whiteBrown),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: brown),
        ),
        labelText: label,
        labelStyle: TextStyle(color: blackColor),
        filled: true,
        fillColor: freewhiteBrown
      ),
      obscureText: obscureText,
      controller: Controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال $label';
        }
        if (email) {
          if (isValidEmail(value)) {
          } else {
            return 'الرجاء ادخال البريد الالكتروني بشكل صحيح';
          }
        }
        return null;
      },
    );
  }
}


bool isValidEmail(String email) {
  RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{3,}$',
  );
  return emailRegExp.hasMatch(email);
}