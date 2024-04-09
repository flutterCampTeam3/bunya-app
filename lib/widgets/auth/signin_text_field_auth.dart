import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';

class SignintextFieldAuth extends StatelessWidget {
   SignintextFieldAuth({
    Key? key,
    required this.Controller,
    required this.label,
      required this.obscureText
  });
 bool obscureText =true;
  final Controller;
  String label;

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
        return null;
      },
    );
  }
}
