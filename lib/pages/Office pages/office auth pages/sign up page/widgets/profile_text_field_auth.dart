import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';

class ProfiletextFieldAuth extends StatelessWidget {
   ProfiletextFieldAuth({
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
          labelStyle: TextStyle(color: blackColor,fontWeight: FontWeight.w400),
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
      ),
    );
  }
}
