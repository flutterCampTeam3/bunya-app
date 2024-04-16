import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';

class TextFieldConfirmPass extends StatefulWidget {
  const TextFieldConfirmPass({
    Key? key,
    required this.confController,
    required this.passController,
  }) : super(key: key);

  final TextEditingController confController;
  final TextEditingController passController;

  @override
  _TextFieldConfirmPassState createState() => _TextFieldConfirmPassState();
}

class _TextFieldConfirmPassState extends State<TextFieldConfirmPass> {
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
          borderSide: BorderSide(color:brown),
        ),
        labelText: "تأكيد كلمة المرور",
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
      controller: widget.confController,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال تأكيد كلمة المرور';
        } else if (value != widget.passController.text) {
          return 'تأكيد كلمة المرور غير متطابق';
        }
        return null;
      },
    );
  }
}
