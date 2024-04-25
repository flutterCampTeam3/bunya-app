import 'package:bunya_app/data/model/post_model.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/bloc/like_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// ignore: must_be_immutable
class PostProfileWidget extends StatelessWidget {
  PostProfileWidget(
      {super.key,
      this.name,
      required this.path,
      this.profilePath,
      required this.desc});
  final postModel path;
  String? name;
  String? profilePath;
  final postModel desc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikeBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<LikeBloc>();
        bloc.add(GetLikeNumberEvent(id: desc.postId));
        bloc.add(CheckLikeEvent(id: desc.postId));
        return BlocBuilder<LikeBloc, LikeState>(
          builder: (context, state) {
            return Column(
              children: [
                Stack(
                  children: [
                    // Background image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(path.image,
                          height: 370,
                          width: double.infinity,
                          fit: BoxFit.cover, errorBuilder:
                              (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                        return Image.asset("assets/images/noimage.png");
                      }),
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
                    Positioned(
                        right: 15,
                        bottom: 0,
                        child: bloc.isLike
                            ? InkWell(
                                onTap: () {
                                  bloc.add(DeleteLikeEvent(id: desc.postId));
                                },
                                child: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  bloc.add(AddLikeEvent(post: desc));
                                },
                                child:
                                    const Icon(Icons.favorite_border_outlined)))
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Text(
                      "${bloc.number} لايك",
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      desc.desc,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                )
              ],
            );
          },
        );
      }),
    );
  }
}
