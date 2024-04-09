import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/widgets/auth/page_header.dart';
import 'package:bunya_app/widgets/auth/text_field_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/auth/button_widget.dart';
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
      child: Scaffold(
       
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: SizedBox(
              width: context.getWidth(),
              height: context.getHeight() * .8,
              child: BlocConsumer<PasswordResetBloc, PasswordResetState>(
                listener: (context, state) {
                  if (state is OtpErrorState) {
                    context.showErrorSnackBar(context, state.msg);
                  } else if (state is EmailVerifiedState) {
                    context.showSuccessSnackBar(context, state.msg);
                    context.pushTo(view: VerifyOtpPage(email: emailController.text,));
                  }
                },
                builder: (context, state) {
                  final prBloc = context.read<PasswordResetBloc>();
                  if (state is OtpLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: whiteBrown,
                      ),
                    );
                  }else {
                    return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/emails.png"),
                      Text(
                        "هل نسيت كلمة المرور؟",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: blackColor,
                          fontSize: context.getWidth() * .06,
                        ),
                      ),
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
                     textFieldAuth(Controller: emailController, label: 'البريد الإلكتروني', obscureText: false,),
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
                  }
                  
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
