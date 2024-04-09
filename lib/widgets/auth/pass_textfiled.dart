import 'package:flutter/material.dart';

import '../../helper/colors.dart';

class PassTextField extends StatefulWidget {
  const PassTextField({
    Key? key,
    required this.controller,
   
  }) : super(key: key);

  final TextEditingController controller;
  

  @override
  _PassTextFieldState createState() => _PassTextFieldState();
}

class _PassTextFieldState extends State<PassTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color:whiteBrown),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: whiteBrown),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: brown),
        ),
        labelText:"كلمة المرور",
        labelStyle: TextStyle(color: blackColor),
        filled: true,
        fillColor: freewhiteBrown,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(
            obscureText ? Icons.visibility_off  : Icons.visibility,
            color: whiteBrown,
          ),
        ),
      ),
      obscureText: obscureText,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال كلمة المرور';
        }
        return null;
      },
    );
  }
}
