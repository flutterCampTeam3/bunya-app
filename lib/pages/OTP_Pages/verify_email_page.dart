import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/widgets/auth/text_field_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/auth/button_widget.dart';
import 'bloc/password_reset_bloc.dart';
import 'verify_otp_page.dart';

// ignore: must_be_immutable
class VerifyEmailPage extends StatelessWidget {
  VerifyEmailPage({super.key});
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordResetBloc(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: SizedBox(
                width: context.getWidth(),
                height: context.getHeight() * .8,
                child: BlocConsumer<PasswordResetBloc, PasswordResetState>(
                    listener: (context, state) {
                  if (state is OtpErrorState) {
                    Navigator.pop(context);
                    context.showErrorSnackBar(context, state.msg);
                  } else if (state is EmailVerifiedState) {
                    Navigator.pop(context);
                    context.showSuccessSnackBar(context, state.msg);
                    context.pushTo(
                        view: VerifyOtpPage(
                      remail: emailController.text,
                    ));
                  }
                  if (state is OtpLoadingState) {
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
                }, builder: (context, state) {
                  final prBloc = context.read<PasswordResetBloc>();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/emails.png",
                        height: 200,
                      ),
                      gapH20,
                      Text(
                        "هل نسيت كلمة المرور؟",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: blackColor,
                          fontSize: context.getWidth() * .06,
                        ),
                      ),
                      gapH20,
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "يرجى إدخال الإيميل الخاص بك",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: blackColor,
                              fontSize: context.getWidth() * .05,
                            ),
                          )),
                      gapH20,
                      textFieldAuth(
                        Controller: emailController,
                        label: 'البريد الإلكتروني',
                        obscureText: false,
                        email: true,
                      ),
                      gapH20,
                      ButtonWidget(
                          backgroundColor: brown,
                          text: "إرسال الرمز",
                          textColor: whiteColor,
                          onPressed: () {
                            prBloc
                                .add(SendOtpEvent(email: emailController.text));
                          })
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
