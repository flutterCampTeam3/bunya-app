import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/widgets/auth/page_header.dart';
import 'package:bunya_app/widgets/auth/text_field_auth.dart';
import 'package:bunya_app/widgets/auth/text_field_confirm_pass.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../helper/sized.dart';
import '../../../Office pages/office auth pages/sign up page/bloc/sign_up_bloc.dart';
import '../../../../widgets/auth/button_widget.dart';
import '../../../../widgets/auth/pass_textfiled.dart';
import '../signIn page/signin_customer_page.dart';
import 'bloc/sign_up_bloc.dart';

class SignUpCustomerPage extends StatelessWidget {
  const SignUpCustomerPage({Key? key});

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
     TextEditingController phoneController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController confirmPassController = TextEditingController();

    return BlocProvider(
      create: (context) => SignUpBlocCustomer(),
      child: Builder(builder: (context) {
        final bloc = context.read<SignUpBlocCustomer>();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 280),
            child: const PageHeader(
              height: 150,
              bottomText: "تسجيل حساب",
            ),
          ),
          body: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SuccessSignUpState) {
                // SignUp Function Here
              }
              if (state is ErrorSignUpState) {
                // Error SignUp Function Here
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Form(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          textFieldAuth(Controller: nameController, label: 'الاسم ', obscureText: false,),
                          gapH20,
                          textFieldAuth(Controller: emailController, label: 'البريد الإلكتروني', obscureText: false,),
                          gapH20,
                            textFieldAuth(Controller: phoneController, label: 'رقم الجوال ', obscureText: false,),
                          gapH20,
                   
                        PassTextField(controller: passController,),
                          gapH20,
                          TextFieldConfirmPass(confController: confirmPassController, passController: passController),
                          gapH10,
                          Row(
                            children: [
                              Text("موافق على الشروط والأحكام",style: TextStyle(color: blackColor,fontSize: 14,fontWeight: FontWeight.w600),),
                              // Checkbox(value: isChecked, onChanged: 
                              // ),
                            ],
                          ),
                          gapH20,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ButtonWidget(
                                  backgroundColor: darkBrown,
                                  text: "تسجيل الحساب",
                                  onPressed: () {
                                    if (Form.of(context)!.validate()) {
                                      bloc.add(CreateAccountCustomerEvent(
                                        email: emailController.text,
                                        password: passController.text,
                                        name: nameController.text,
                                       
                                       phone: phoneController.text,

                                        confirmPass: confirmPassController.text,
                                        isChecked: isChecked,
                                      ));
                                    }
                                  },
                                  textColor: Colors.white,
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "يوجد لديك حساب بالفعل؟  ",
                                        style: TextStyle(
                                          color: whiteBrown,
                                          fontSize: 15,
                                          fontFamily: GoogleFonts.vazirmatn().fontFamily,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "تسجيل الدخول",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: darkBrown,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: GoogleFonts.vazirmatn().fontFamily,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(builder: (context) => SigninCustomerPage()),
                                              (Route<dynamic> route) => false,
                                            );
                                          },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}






