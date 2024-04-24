import 'package:bunya_app/pages/OTP_Pages/verify_email_page.dart';
import 'package:bunya_app/pages/Office%20pages/navBar%20page/navBarPage.dart';
import 'package:bunya_app/pages/costumer%20pages/navBar%20page/navBarPage.dart';
import 'package:bunya_app/pages/intro%20pages/first_intro.dart';
import 'package:bunya_app/pages/OTP_Pages/widgets/auth/signin_pass_textfiled.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/OTP_Pages/widgets/auth/button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../OTP_Pages/widgets/auth/signin_text_field_auth.dart';
import '../sign up page/signup_page.dart';
import 'bloc/sign_in_bloc.dart';
import 'widgets/page_header_signin.dart';

class SigninCustomerPage extends StatefulWidget {
  const SigninCustomerPage({super.key});

  @override
  State<SigninCustomerPage> createState() => _SigninCustomerPageState();
}

class _SigninCustomerPageState extends State<SigninCustomerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController =
        TextEditingController(text: "shaimaa@gmail.com");
    TextEditingController passController =
        TextEditingController(text: "112233");
    return BlocProvider(
      create: (context) => SignInCustomerBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<SignInCustomerBloc>();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size(context.getWidth(), 400),
                child: const PageHeaderSignIn(
                  height: 400,
                  bottomText: " نورتنا من جديد ",
                )),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: context.getHeight() * .5,
                  child: BlocConsumer<SignInCustomerBloc, SignInCustomerState>(
                      listener: (context, state) {
                    if (state is SuccessSignInCustomerState) {
                      // SuccessSignInState Function Here
                      Navigator.pop(context);
                      context.showSuccessSnackBar(context, state.msg);
                      // BottomBarScreen Here

                      if (bloc.userType) {
                        context.pushAndRemove(const NavBarPage());
                      } else {
                        context.pushAndRemove(const NavBarOfficePage());
                      }
                    }
                    if (state is ErrorSignInCustomerState) {
                      Navigator.pop(context);
                      context.showErrorSnackBar(context, state.massage);
                    }
                    if (state is LoadingSignInCustomerState) {
                      showDialog(
                          barrierDismissible: false,
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return const SizedBox(
                              height: 80,
                              width: 80,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          });
                    }
                  }, builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SignintextFieldAuth(
                                Controller: emailController,
                                label: 'البريد الإلكتروني',
                                obscureText: false,
                                email: true,
                              ),
                              gapH30,
                              SigninPassTextField(
                                controller: passController,
                              ),
                              gapH10,
                              InkWell(
                                  onTap: () {
                                    // Here VerifyEmailPage
                                    context.pushTo(view: VerifyEmailPage());
                                  },
                                  child: const Text(
                                    "هل نسيت كلمة المرور؟",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        // color: blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              // gapH10,
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ButtonWidget(
                                backgroundColor: brown,
                                text: "تسجيل دخول",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    print("------");
                                    bloc.add(AddSignInCustomerEvent(
                                        email: emailController.text,
                                        password: passController.text));
                                  }
                                },
                                textColor: whiteColor,
                              ),
                              gapH15,
                              InkWell(
                                onTap: () {
                                  context.pushTo(view: const introPage());
                                },
                                child: ButtonWidget(
                                  backgroundColor: darkBrown,
                                  text: "تغيير حساب المستخدم",
                                  onPressed: () {
                                    context.pushTo(view: const introPage());
                                  },
                                  textColor: whiteColor,
                                ),
                              ),
                              gapH10,
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: "لا يوجد لديك حساب؟  ",
                                    style: TextStyle(
                                      color: whiteBrown,
                                      fontSize: 15,
                                      fontFamily:
                                          GoogleFonts.vazirmatn().fontFamily,
                                    ),
                                  ),
                                  TextSpan(
                                      text: "سجل الآن",
                                      style: TextStyle(
                                        // color: darkBrown,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontFamily:
                                            GoogleFonts.vazirmatn().fontFamily,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context.pushAndRemove(
                                              const SignUpCustomerPage());
                                        })
                                ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
