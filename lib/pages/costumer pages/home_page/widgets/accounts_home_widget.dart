import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:flutter/material.dart';

class AccountsHomeWidget extends StatelessWidget {
  AccountsHomeWidget(
      {super.key,
      required this.description,
      required this.path,
      required this.title});

  String path;
  String title;
  String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: darkGreyColor.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: blackColor,
                  width: 1,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            gapWe10,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(
                  description,
                  style: TextStyle(fontSize: 9, color: darkGreyColor),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Rate",
                  style: TextStyle(color: darkGreyColor),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: yellow,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: yellow,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: yellow,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: yellow,
                      size: 15,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
