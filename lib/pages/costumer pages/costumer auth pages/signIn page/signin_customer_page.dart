import 'package:bunya_app/widgets/auth/signin_pass_textfiled.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/widgets/auth/button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets/auth/signin_text_field_auth.dart';
import '../sign up page/signup_page.dart';
import 'bloc/sign_in_bloc.dart';
import 'widgets/page_header_signin.dart';


class SigninCustomerPage extends StatelessWidget {
  const SigninCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return BlocProvider(
      create: (context) => SignInCustomerBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<SignInCustomerBloc>();
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(context.getWidth(), 400),
              child: const PageHeaderSignIn(height: 400,bottomText: " نورتنا من جديد ", )),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: context.getHeight() * .5,
                child: BlocConsumer<SignInCustomerBloc, SignInCustomerState>(
                  listener: (context, state) {
                    if (state is SuccessSignInCustomerState) {

                       // SuccessSignInState Function Here
                      // context.showSuccessSnackBar(context, state.msg);


                      // BottomBarScreen Here
                      // context.pushAndRemove(const BottomBarScreen());
                    }
                    if (state is ErrorSignInCustomerState) {
                       context.showErrorSnackBar(context,state.massage);
                      
                    }
                    if (state is SuccessResetCustomerState) {
                   // SuccessResetState Function Here
                      // context.showSuccessSnackBar(context, state.msg);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingSignInCustomerState) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: freewhiteBrown,
                        ),
                      );
                    } else {
                    return Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             SignintextFieldAuth(Controller: emailController, label: 'البريد الإلكتروني', obscureText: false,),
                          gapH40,
                           SigninPassTextField(controller: passController,),
                         gapH20,

                            TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0)),
                                onPressed: () {
                                  // Here VerifyEmailPage 
                                  // context.pushTo(view: VerifyEmailPage());
                                },
                                child: Text(
                                  "هل نسيت كلمة المرور؟",
                                  style: TextStyle(
                                      color: blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ButtonWidget(
                              backgroundColor: darkBrown,
                              text: "تسجيل دخول",
                              onPressed: () {
                                if (Form.of(context)!.validate()){
                                   bloc.add(AddSignInCustomerEvent(
                                    email: emailController.text,
                                    password: passController.text));
                                }
                               
                              },
                              textColor: whiteColor,
                            ),
                            gapH15,
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "لا يوجد لديك حساب؟  ",
                                   style: TextStyle(
                                          color: whiteBrown,
                                          fontSize: 15,
                                          fontFamily: GoogleFonts.vazirmatn().fontFamily,
                                        ),
                                ),
                                TextSpan(
                                    text: "سجل الآن",
                                     style: TextStyle(
                                          color: darkBrown,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: GoogleFonts.vazirmatn().fontFamily,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context
                                            .pushAndRemove(const SignUpCustomerPage());
                                      })
                              ]),
                            ),
                          ],
                        ),
                      ],
                    );
                    }
                  },
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
