import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';

class EditInfoRowCustomer extends StatelessWidget {
  EditInfoRowCustomer({
    super.key,
    required this.title,
    required this.controller
  });
  String title;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(title),
        ),
        Expanded(
          child: TextField(
            style: TextStyle(color: darkGreyColor),
            maxLines: null,
            controller: controller,
          ),
        )
      ],
    );
  }
}
