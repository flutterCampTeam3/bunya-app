import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/pages/OTP_Pages/bloc/password_reset_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../widgets/auth/button_widget.dart';

// ignore: must_be_immutable
class VerifyOtpPage extends StatelessWidget {
  VerifyOtpPage({super.key, required this.email});
  TextEditingController otpController = TextEditingController();
  final String email
;
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
                  } else if (state is OtpVerifiedState) {
                    context.showSuccessSnackBar(context, state.msg);
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
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                VerifyOtpEvent(otpToken: value, email: email));
                          },
                        ),
                        ButtonWidget(
                            backgroundColor: brown,
                            text: "تحقق",
                            textColor: whiteColor,
                            onPressed: () {
                              prBloc.add(
                                  VerifyOtpEvent(otpToken: otpController.text, email: email));
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
