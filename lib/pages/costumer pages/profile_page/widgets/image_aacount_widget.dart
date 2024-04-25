import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageAacountWodget extends StatelessWidget {
  ImageAacountWodget({super.key, required this.path});
  String path;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: blackColor,
          width: 1,
        ),
      ),
      child: ClipOval(
        child: Image.network(path, fit: BoxFit.cover, errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return Image.asset("assets/images/profil.png");
        }),
      ),
    );
  }
}
