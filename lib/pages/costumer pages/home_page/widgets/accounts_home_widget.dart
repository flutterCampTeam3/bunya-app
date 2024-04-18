import 'package:bunya_app/data/model/offices_model.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:flutter/material.dart';

class AccountsHomeWidget extends StatelessWidget {
  AccountsHomeWidget(
      {super.key,
      required this.description,
      required this.path,
      required this.title});

  final OfficesModel path;
   final OfficesModel title;
   final OfficesModel description;
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
                child: Image.network(
                  path.image,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              return Image.asset("assets/images/noimage.png");
                          }
                ),
              ),
            ),
            gapWe10,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title.name),
                Text(
                  description.disc,
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
