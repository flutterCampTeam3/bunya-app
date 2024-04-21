import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/OTP_Pages/bloc/password_reset_bloc.dart';
import 'package:bunya_app/pages/OTP_Pages/change_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../widgets/auth/button_widget.dart';
import 'package:timer_button/timer_button.dart';

// ignore: must_be_immutable
class VerifyOtpPage extends StatelessWidget {
  VerifyOtpPage({super.key, required this.remail});
  TextEditingController otpController = TextEditingController();
  final String remail;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordResetBloc(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_forward_ios_outlined)),
          ],
        ),
        backgroundColor: whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: SizedBox(
              width: context.getWidth(),
              height: context.getHeight() * .8,
              child: BlocConsumer<PasswordResetBloc, PasswordResetState>(
                listener: (context, state) {
                  // if (state is OtpVerifiedState) {
                  //   Navigator.pop(context);
                  //   context.pushTo(view: ChangePasswordPage());
                  // }
                  if (state is OtpErrorState) {
                    Navigator.pop(context);
                    context.showErrorSnackBar(context, state.msg);
                  }
                  if (state is OtpVerifiedState) {
                    Navigator.pop(context);
                    context.showSuccessSnackBar(context, state.msg);
                    context.pushTo(view: ChangePasswordPage());
                  }
                  if (state is AuthOtpResentState) {
                    Navigator.pop(context);
                    context.showSuccessSnackBar(context, state.msg);
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
                },
                builder: (context, state) {
                  final prBloc = context.read<PasswordResetBloc>();

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // gapH30,
                      Image.asset("assets/images/otp.png"),
                      // SvgPicture.asset('assets/repassword.svg'),
                      Text(
                        "تم إرسال الرمز إلى بريدك الإلكتروني",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: blackColor,
                          fontSize: context.getWidth() * .06,
                        ),
                      ),
                      gapH10,
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "يرجى إدخال الرمز للتحقق",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: blackColor,
                              fontSize: context.getWidth() * .05,
                            ),
                          )),
                      gapH20,
                      TimerButton(
                        onPressed: () {
                          prBloc.add(ResendOtpEvent(email: remail));
                        },
                        timeOutInSeconds: 10,
                        buttonType: ButtonType.textButton,
                        color: brown,
                        activeTextStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        disabledColor: Colors.grey,
                        disabledTextStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        label: "إعادة إرسال الرمز",
                      ),
                      gapH10,

                      OtpTextField(
                        alignment: Alignment.centerLeft,
                        showFieldAsBox: true,
                        disabledBorderColor: whiteBrown,
                        fillColor: freewhiteBrown,
                        filled: true,
                        focusedBorderColor: whiteBrown,
                        enabled: true,
                        enabledBorderColor: brown,
                        borderRadius: BorderRadius.circular(10),
                        fieldWidth: context.getWidth() * .12,
                        fieldHeight: context.getHeight() * .09,
                        borderColor: freewhiteBrown,
                        numberOfFields: 6,
                        obscureText: true,
                        onSubmit: (value) {
                          prBloc.add(
                              VerifyOtpEvent(otpToken: value, email: remail));
                        },
                      ),
                      const Spacer(),
                      ButtonWidget(
                          backgroundColor: brown,
                          text: "تحقق",
                          textColor: whiteColor,
                          onPressed: () {
                            prBloc.add(VerifyOtpEvent(
                                otpToken: otpController.text, email: remail));
                          })
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
