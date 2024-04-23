import 'package:bunya_app/data/model/offices_model.dart';
import 'package:bunya_app/data/model/post_model.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/costumer%20pages/home_page/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PostWidget extends StatelessWidget {
  const PostWidget(
      {super.key,
      required this.postPath,
      required this.description,
      required this.profilePath});
  final postModel postPath;
  final postModel description;
  final OfficesModel profilePath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..add(ShowDataEvent())
        ..add(CheckLikeHomeEvent(id: description.postId)),
      child: Builder(
        builder: (context) {
          final bloc = context.read<HomeBloc>();

          return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.surface,
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
                  padding:
                      const EdgeInsets.only(right: 8.0, left: 8, bottom: 8),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 145,
                        child: Stack(
                          children: [
                            Positioned(
                              // top: 0,
                              child: Container(
                                height: 120,
                                // context.getHeight() * 0.3,
                                width: MediaQuery.of(context).size.width * 0.3,
                                ///////////////
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
                                  child: Image.network(postPath.image,
                                      fit: BoxFit.cover, errorBuilder:
                                          (BuildContext context, Object error,
                                              StackTrace? stackTrace) {
                                    return Image.asset(
                                        "assets/images/noimage.png");
                                  }),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              child: !bloc.isHomeLike
                                  ? InkWell(
                                      onTap: () {
                                        bloc.add(AddLikeHomeEvent(
                                            post: description));
                                      },
                                      child: const Icon(
                                        Icons.favorite_border,
                                        color: Colors.black,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        bloc.add(DeleteLikeHomeEvent(
                                            id: description.postId));
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        color: red,
                                      ),
                                    ),
                            ),
                            Positioned(
                                bottom: 0,
                                child: Text("${bloc.likeNumber} لايك",
                                    style: GoogleFonts.balooBhaijaan2(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )))
                          ],
                        ),
                      ),
                      Text(
                        description.desc ?? " ",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(color: blackColor),
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
                                color: blackColor,
                                width: 1,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                profilePath.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          gapWe5,
                          Expanded(
                            child: Text(
                              profilePath.name,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
