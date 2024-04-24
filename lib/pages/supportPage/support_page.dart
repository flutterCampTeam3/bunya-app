import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/supportPage/bloc/support_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helper/colors.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    late TextEditingController massageController = TextEditingController();
   
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => SupportBloc(),
        child: Builder(builder: (context) {
          final bloc = context.read<SupportBloc>();
          return Scaffold(
            appBar: AppBar(
              leading: Container(
                child: TextButton(
                  onPressed: () {
                    context.popNav();
                  },
                  child: Text("الغاء",
                      style: TextStyle(
                          fontSize: 17,
                          color: blackColor,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            body: BlocConsumer<SupportBloc, SupportState>(
              listener: (context, state) {
                if (state is SuccessSendState) {
                  Navigator.pop(context);
                  context.showSuccessSnackBar(context, state.msg);
                  context.popNav();
                }
                if(state is ErrorSendState){
                  Navigator.pop(context);
                  context.showErrorSnackBar(context, state.msg);
                }
                if (state is LoadingSendState){
                   showDialog(
                      barrierDismissible: false,
                      barrierColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          content: SizedBox(
                            height: 80,
                            width: 80,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      });
                }
              },
              builder: (context, state) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 360,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/support.png"),
                                  fit: BoxFit.contain)),
                        ),
                        Center(
                          child: Text(
                            "  مرحبًا بك!   يُسرنا أن تبلغنا عن أي مشكلة",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            " وسوف نحلها لك",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        // SizedBox(height: 20.0),
                        // Text(
                        //   'يرجى كتابة رسالتك هنا :',
                        //   style: TextStyle(fontSize: 18.0),
                        // ),
                        SizedBox(height: 10.0),
                        // GestureDetector(
                        //   onTap: () {
                        //     // Implement your email functionality here
                        //   },
                        //   child: Text(
                        //     'support@example.com',
                        //     style: TextStyle(
                        //       fontSize: 18.0,
                        //       color: Colors.blue,
                        //       decoration: TextDecoration.underline,
                        //     ),
                        //   ),
                        // ),
                        gapH10,

                        gapH20,
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'اكتب رسالتك هنا  ',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          controller: massageController,
                          // Add a controller if you want to capture the input
                        ),
                        SizedBox(
                          height: 20.0,
                          width: context.getWidth() / 5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            bloc.add(SendMassageEvent(
                                massage: massageController.text));
                          },
                          child: Text(
                            'ارسال',
                            style: TextStyle(color: blackColor, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
