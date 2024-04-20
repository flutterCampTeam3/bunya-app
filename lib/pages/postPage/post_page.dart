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
  const PostPage({super.key, required this.post, required this.Office});
  final postModel post;
  final OfficesModel Office;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostPageBloc()..add(ShowPostDataIdEvent(id: Office.officeId)),
      child: Builder(builder: (context) {
        final bloc = context.read<PostPageBloc>();

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    context.popNav();
                  },
                  icon: Icon(Icons.arrow_back_ios_new)),
            ),
            body: BlocConsumer<PostPageBloc, PostPageState>(
                listener: (context, state) {
              if (state is ErrorPostShowpostState) {
                // Navigator.pop(context);
                context.showErrorSnackBar(context, state.msg);
              }
            }, builder: (context, state) {
              if (state is LoadingPostState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: brown,
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
                                Office.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          gapWe5,
                          Text(
                            (Office.name),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          ElevatedButton(
                              onPressed: () {},
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
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "100 لايك",
                            style: TextStyle(
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
                            // "اضائات جميلة بمواصفات مميزه وحديثه وتتمع بمزايا عديده لجعل شقتك او منزلك يبدو افضل واجمل وايضا تمتاز باستهلاكها القليل للطاقة كل ذالك بسعر مميز واقتصادي"
                            post.desc,
                            
                            style: TextStyle(
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
        );
      }),
    );
  }
}
