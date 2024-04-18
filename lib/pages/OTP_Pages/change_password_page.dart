import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/pages/OTP_Pages/bloc/password_reset_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/auth/button_widget.dart';
import '../widgets/auth/pass_textfiled.dart';
import '../widgets/auth/text_field_confirm_pass.dart';
import '../Office pages/office auth pages/signIn page/signin_page.dart';

// ignore: must_be_immutable
class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

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
                  if (state is PasswordChangedState) {
                    context.showSuccessSnackBar(context, state.msg);
                    context.pushAndRemove(const SigninPage());
                  }
                  if (state is OtpLoadingState) {
                    
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
                      Image.asset("assets/images/reset.png", height: 280,),
                      Text(
                        "تم التحقق من بريدك بنجاح",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: blackColor,
                          fontSize: context.getWidth() * .06,
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "يرجى إدخال كلمة المرور الجديدة",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: blackColor,
                              fontSize: context.getWidth() * .05,
                            ),
                          )),
                     PassTextField(controller: passwordController),
                     TextFieldConfirmPass(confController:rePasswordController, passController: passwordController ),
                      ButtonWidget(
                          backgroundColor: brown,
                          text: "إعادة تعيين كلمة المرور",
                          textColor: whiteColor,
                          onPressed: () {
                            prBloc.add(ChangePasswordEvent(password: passwordController.text, rePassword: rePasswordController.text));
                            context.pushAndRemove(SigninPage());
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
