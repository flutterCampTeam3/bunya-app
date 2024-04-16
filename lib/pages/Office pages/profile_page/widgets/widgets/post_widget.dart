import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class PostProfileWidget extends StatelessWidget {
  PostProfileWidget(
      {super.key,
      required this.name,
      required this.path,
      required this.profilePath,
      required this.likes,
      required this.desc});
  String path;
  String name;
  String profilePath;
  String likes;
  String desc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
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
            // const Positioned(
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(20),
            //       bottomRight: Radius.circular(20),
            //     ),
            //     // child: GlassContainer(
            //     //   height: 80,
            //     //   blur: 10,
            //     //   color: Colors.black.withOpacity(0.2),
            //     //   shadowColor: Colors.black.withOpacity(0.24),
            //     // ),
            //   ),
            // ),
            // Positioned(
            //     right: 20,
            //     top: 20,
            //     child: Row(
            //       children: [
            //         Container(
            //           width: 50,
            //           height: 50,
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             border: Border.all(
            //               color: brownColor,
            //               width: 7,
            //             ),
            //           ),
            //           child: ClipOval(
            //             child: Image.asset(
            //               profilePath,
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //         ),
            //         gapWe5,
            //         Text(
            //           name,
            //           style: TextStyle(
            //               fontSize: 13,
            //               fontWeight: FontWeight.w900,
            //               color: whiteColor),
            //         ),
            //       ],
            //     )),
            const Positioned(right: 15, bottom: 0, child: Icon(Icons.favorite))
          ],
        ),
        const Divider(),
        Row(
          children: [
            Text(
              likes,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
        Row(
          children: [
            Text(
              desc,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        )
      ],
    );
  }
}
