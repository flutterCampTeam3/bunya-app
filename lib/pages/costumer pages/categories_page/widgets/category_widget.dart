import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key, required this.name, required this.path , required this.onTap});
  String path;
  String name;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          // Background image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              path,
              height: 370,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Glass container
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: GlassContainer(
                height: 100,
                blur: 10,
                color: Colors.black.withOpacity(0.2),
                shadowColor: Colors.black.withOpacity(0.24),
              ),
            ),
          ),
          Positioned(
              right: 20,
              bottom: 35,
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 16, color: whiteColor, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
