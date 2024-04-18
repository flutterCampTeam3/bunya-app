import 'package:bunya_app/data/model/offices_model.dart';
import 'package:bunya_app/data/model/post_model.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/edit_office_page.dart';
import 'package:bunya_app/pages/Office%20pages/profile_page/widgets/widgets/information_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/image_aacount_widget.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/widgets/post_widget.dart';
import 'package:bunya_app/pages/intro%20pages/customer/first_intro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/profile_posts_bloc.dart';

class ProfilePageOfficeCustomur extends StatelessWidget {
  const ProfilePageOfficeCustomur({super.key, required this.office});
  final OfficesModel office;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePostsBloc()..add( ShowDataIdEvent(id: office.officeId) ),
      child: Builder(
        builder: (context) {
          final bloc =context.read<ProfilePostsBloc>();
          return Directionality(
              textDirection: TextDirection.rtl,
              child: DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: Scaffold(
                  backgroundColor: whiteColor,
                  body: SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ImageAacountWodget(
                              path: office.image,
                            ),
                            gapWe15,
                            Column(
                              children: [Text(office.name), Text(office.email)],
                            )
                          ],
                        ),
                        gapH20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                //
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(lightBrown),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(150, 50)),
                              ),
                              child: const Text(
                                'محادثة',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            Visibility(
                              visible: false,
                              child: ElevatedButton(
                                onPressed: () {
                                  //
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(lightBrown),
                                  fixedSize: WidgetStateProperty.all<Size>(
                                      const Size(150, 50)),
                                ),
                                child: const Text(
                                  'الغاء المتابعة ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Visibility(
                              
                              visible: true,
                              child: ElevatedButton(
                                onPressed: () {
                                  //
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(lightBrown),
                                  fixedSize: WidgetStateProperty.all<Size>(
                                      const Size(150, 50)),
                                ),
                                child: const Text(
                                  'متابعة',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        gapH20,
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [                        
                              const Column(
                                children: [
                                  Text("المتابَعون"),
                                  gapH20,
                                  Text("500"),
                                ],
                              ),
                              VerticalDivider(
                                width: 30.0,
                                thickness: 1.0,
                                color: blackColor,
                              ),
                              const Column(
                                children: [
                                  Text("المتابِعون"),
                                  gapH20,
                                  Text("90"),
                                ],
                              ),
                              VerticalDivider(
                                width: 30.0,
                                thickness: 1.0,
                                color: blackColor,
                              ),
                              const Column(
                                children: [
                                  Text("الإعجابات"),
                                  gapH20,
                                  Text("1500"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        gapH20,
                        Container(
                          padding: const EdgeInsets.all(2),
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: lightbrownColor),
                          child: TabBar(
                            onTap: (value) {
                              print("object");
                            },
                            // indicatorSize: TabBarIndicatorSize.values[2],
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: RadialGradient(
                                    colors: [whiteColor, whiteColor])),
                            tabs: [
                              Tab(
                                icon: SizedBox(
                                  width: 80,
                                  child: Image.asset(
                                    'assets/images/person_icon.png',
                                    height: 20,
                                    width: 45,
                                  ),
                                ),
                              ),
                              Tab(
                                icon: SizedBox(
                                  width: 80,
                                  child: Image.asset(
                                    'assets/images/post_icon.png',
                                    height: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        gapH20,
                        Expanded(
                          child: TabBarView(children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  // Align(
                                  //   alignment: Alignment.topLeft,
                                  //   child: IconButton(
                                  //       onPressed: () {
                                  //         Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //             builder: (context) {
                                  //               // Return the widget for the new route here
                                  //               return EditPageOffice(
                                  //                 name: state.name,
                                  //               );
                                  //             },
                                  //           ),
                                  //         );
                                  //       },
                                  //       icon: Image.asset(
                                  //         'assets/images/edit.png',
                                  //         width: 18,
                                  //       )),
                                  // ),
                                  InformationWidgetOffice(
                                    widget: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "معلومات الشركة :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        gapH5,
                                        Text(
                                          office.disc,
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                  gapH20,
                                  InformationWidgetOffice(
                                    widget: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "معلومات التواصل :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        gapH5,
                                        Text(
                                          office.email,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          office.phoneNumber,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          office.name,
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                             BlocConsumer<ProfilePostsBloc,ProfilePostsState>(
                              listener:(context,state){
                                if (state is ErrorprofileShowpostState){ 
                                   Navigator.pop(context);
                                context.showErrorSnackBar(context, state.msg);
                                }
                              },
                              builder: (context, state) {
                                if (state is LoadingState) {
                
                                 return Center(
                                   child: CircularProgressIndicator(
                                  color: brown,
                             ),
                );
              } else if (state is profilePostsSuccesState ){
                return SizedBox(
                  child:GridView.builder(
                    gridDelegate: 
                    SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.75,
            ),
                    
                    itemCount: state.classPostId.length,
                     itemBuilder: (context, index) {
                      return PostProfileWidget(desc: state.classPostId[index],path: state.classPostId[index],);
                       
                     }
                     
                     ) ,
                );
              }else {
                return SizedBox();
              }
                              
                              },
                              )
                            // SingleChildScrollView(
                            //   child: Column(
                            //     children: [
                            //       PostProfileWidget(
                            //         path:post!.image,
                            //         desc:
                            //             post!.desc,
                            //       ),
                            //       gapH15,
                            //       PostProfileWidget(
                            //        path:post!.image,
                            //         likes: "100 لايك",
                            //         desc:
                            //             post!.desc,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ]),
                        ),
                      ],
                    ),
                  )),
                ),
              ));
        }
      ),
    );
  }
}
