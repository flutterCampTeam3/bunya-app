import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/pages/Office%20pages/add%20post%20page/bloc/post_bloc.dart';
import 'package:bunya_app/pages/Office%20pages/navBar%20page/navBarPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/sized.dart';
import '../../widgets/auth/button_widget.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  Widget build(BuildContext context) {
    late TextEditingController descController = TextEditingController();

    @override
    void initState() {
      super.initState();
      descController = TextEditingController();
    }

    @override
    void dispose() {
      descController = TextEditingController();
      super.dispose();
    }

    return BlocProvider(
      create: (context) => PostBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<PostBloc>();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            // backgroundColor: white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                backgroundColor: whitegrey,
                leading: TextButton(
                  onPressed: () {
                    Navigator.pop(context, const NavBarOfficePage());
                  },
                  child: Text("الغاء",
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColor,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            body: ListView(padding: const EdgeInsets.all(20.0), children: [
              Center(
                  child: Column(
                children: [
                  Text(
                    "اضافة منشور",
                    style: TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                  gapH10,
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: BlocBuilder<PostBloc, PostState>(
                      builder: (context, state) {
                        if (state is ShowImagepostState) {
                          return Container(
                            height: 400,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                border: Border.all(color: darkGreyColor),
                                image: DecorationImage(
                                    image: FileImage(state.PickedImage),
                                    fit: BoxFit.cover)),
                          );
                        }
                        return Container(
                          height: 300,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(color: darkGreyColor)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      bloc.add(ChoseImagePostEvent());
                                    },
                                    icon: const Icon(
                                      Icons.image,
                                      size: 75,
                                    )),
                                Text(
                                  "اضغط على الايقونة لرفع منشور جديد",
                                  style: TextStyle(
                                      color: darkgreyColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: '   اضافة وصف',
                          hintText: "اضف وصف للعمل الخاص بك ",
                          labelStyle: TextStyle(
                              color: darkGreyColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                          hintStyle: TextStyle(color: darkGreyColor),
                          floatingLabelStyle: TextStyle(
                              color: blackColor,
                              fontSize: 23,
                              fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: whiteColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: darkGreyColor)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: darkGreyColor)),
                          filled: true,
                          fillColor: whiteColor,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 40.0)),
                      textAlignVertical: TextAlignVertical.bottom,
                      maxLines: 3,
                      controller: descController,
                    ),
                  ),
                  gapH20,
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: ButtonWidget(
                      backgroundColor: darkBrown,
                      text: 'نشر',
                      textColor: whiteColor,
                      onPressed: () {},
                    ),
                  )
                ],
              )),
            ]),
          ),
        );
      }),
    );
  }
}
