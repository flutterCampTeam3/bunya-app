import 'package:bunya_app/data/model/post_model.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostWidget extends StatelessWidget {
  PostWidget(
      {super.key,
      required this.postPath,
      required this.description,
      required this.like,
      required this.name,
      required this.profilePath});
  final postModel postPath;
  String like;
  final postModel description;
  String profilePath;
  String name;

  @override
  Widget build(BuildContext context) {
   
    return Expanded(
      child: Container(
        // height: 240,
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
          padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 8),
          child: Column(
            children: [
              SizedBox(
                height: 145,
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width *
                          0.3, ///////////////
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: darkGreyColor.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Image.network(
                         
                          postPath.image, 
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              return Image.asset("assets/images/noimage.png");
                          }
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 15,
                        child: Icon(
                          Icons.favorite,
                          color: red,
                        )),
                    Positioned(
                        bottom: 0,
                        child: Text(like,
                            style: GoogleFonts.balooBhaijaan2(
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )))
                  ],
                ),
              ),
              Text(description.desc,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              ),
          

              gapH15,
              Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: brownColor,
                        width: 3,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        profilePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  gapWe5,
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
