import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget(
      {super.key,
      required this.path,
      required this.title,
      required this.onTap});
  String title;
  String path;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                path,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: 15,
                right: 10,
                child: Text(title,
                    style: GoogleFonts.balooBhaijaan2(
                      textStyle: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            color: blackColor,
                            blurRadius: 2,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
