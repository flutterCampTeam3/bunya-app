import 'package:bunya_app/data/model/offices_model.dart';
import 'package:bunya_app/data/model/post_model.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/sized.dart';

import 'bloc/post_page_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key, required this.post, required this.office});
  final postModel post;
  final OfficesModel office;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostPageBloc()
        ..add(CheckPostFollowEvent(id: office.officeId))
        ..add(CheckLikePostEvent(id: post.postId)),
      child: Builder(builder: (context) {
        final bloc = context.read<PostPageBloc>();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            // backgroundColor: white,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    context.popNav();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: BlocConsumer<PostPageBloc, PostPageState>(
                  listener: (context, state) {
                if (state is ErrorPostShowpostState) {
                  context.showErrorSnackBar(context, state.msg);
                }
                if (state is AddFollowPostState) {
                  context.showSuccessSnackBar(context, state.msg);
                }
                if (state is DeleteFollowPostState) {
                  context.showSuccessSnackBar(context, state.msg);
                }
              }, builder: (context, state) {
                if (state is LoadingPostState) {
                  return SizedBox(
                    height: 100,
                    width: 100,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: brown,
                      ),
                    ),
                  );
                } else if (state is PostsSuccesState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: whiteColor,
                                  width: 3,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  office.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            gapWe5,
                            Text(
                              (office.name),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            bloc.isFollow
                                ? ElevatedButton(
                                    onPressed: () {
                                      bloc.add(DeleteFollowPostEvent(
                                          id: office.officeId));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      "إلغاء المتابعة",
                                      style: TextStyle(
                                          color: blackColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ))
                                : ElevatedButton(
                                    onPressed: () {
                                      bloc.add(AddFollowPostEvent(
                                          id: office.officeId));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      "متابعة",
                                      style: TextStyle(
                                          color: blackColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                          ],
                        ),
                      ),
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(color: darkGreyColor),
                            image: DecorationImage(
                                image: NetworkImage(post.image),
                                fit: BoxFit.cover)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          !bloc.isHomeLike
                              ? IconButton(
                                  onPressed: () {
                                    bloc.add(AddLikePostEvent(id: post.postId));
                                  },
                                  icon: const Icon(Icons.favorite_border))
                              : IconButton(
                                  onPressed: () {
                                    bloc.add(
                                        DeleteLikePostEvent(id: post.postId));
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${bloc.likeNumber} لايك",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      //------------
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.desc,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )

                      //-----------
                    ],
                  );
                } else {
                  return const SizedBox(
                      child: Center(child: Text("لا يوجد منشورات حتى الان")));
                }
              }),
            ),
          ),
        );
      }),
    );
  }
}
