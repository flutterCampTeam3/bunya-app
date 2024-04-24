import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';

class textFieldAuth extends StatelessWidget {
  textFieldAuth({
    super.key,
    required this.Controller,
    required this.label,
    required this.obscureText,
    this.email = false,
    this.cr = false,
    this.unn = false,
    this.phone = false,
  });
  bool obscureText = true;
  final Controller;
  String label;
  bool email;
  bool cr;
  bool unn;
  bool phone;

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
          // labelStyle: TextStyle(color: blackColor),
          filled: true,
          fillColor: freewhiteBrown),
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
        if (cr) {
          if (isValidSaudiUnifiedNumber(value)) {
          } else {
            return 'الرجاء ادخال رقم السجل التجاري بشكل صحيح';
          }
        }
        if (unn) {
          if (isValidSaudiCommercialRegistrationNumber(value)) {
          } else {
            return 'الرجاء ادخال الرقم الوطني الموحد بشكل صحيح';
          }
        }
        if (obscureText) {
          if (value.length >= 6) {
          } else {
            return 'الرقم السري يجب ان يكون اكثر من ٦ ارقام';
          }
        }
        if (phone) {
          if (isValidMobileNumber(value)) {
          } else {
            return ' يجب ان يبدا رقم الجوال ب 05 ويتكون من 10 ارقام';
          }
        }
        return null;
        // return null;
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

bool isValidSaudiUnifiedNumber(String number) {
  RegExp saudiUnifiedNumberRegExp = RegExp(r'^\d{10}$');
  return saudiUnifiedNumberRegExp.hasMatch(number);
}

bool isValidSaudiCommercialRegistrationNumber(String number) {
  RegExp saudiCRNumberRegExp = RegExp(r'^\d{2}-\d{10}$');
  return saudiCRNumberRegExp.hasMatch(number);
}

bool isValidMobileNumber(String value) {
  RegExp mobileRegExp = RegExp(r'^05\d{8}$');
  return mobileRegExp.hasMatch(value);
}
