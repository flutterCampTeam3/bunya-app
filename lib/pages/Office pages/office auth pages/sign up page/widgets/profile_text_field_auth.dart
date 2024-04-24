import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';

class ProfiletextFieldAuth extends StatelessWidget {
  ProfiletextFieldAuth({
    super.key,
    required this.Controller,
    required this.label,
    required this.obscureText,
    this.phone = false,
  });
  bool obscureText = true;
  final Controller;
  String label;
  bool phone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: whiteBrown),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: whiteBrown),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: brown),
            ),
            labelText: label,
            labelStyle:
                TextStyle(color: blackColor, fontWeight: FontWeight.w400),
            filled: true,
            fillColor: freewhiteBrown),
        obscureText: obscureText,
        controller: Controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الرجاء إدخال $label';
          }
          if (phone) {
            if (isValidMobileNumber(value)) {
            } else {
              return ' يجب ان يبدا رقم الجوال ب 05 ويتكون من 10 ارقام';
            }
          }

          return null;
        },
      ),
    );
  }
}

bool isValidMobileNumber(String value) {
  RegExp mobileRegExp = RegExp(r'^05\d{8}$');
  return mobileRegExp.hasMatch(value);
}
