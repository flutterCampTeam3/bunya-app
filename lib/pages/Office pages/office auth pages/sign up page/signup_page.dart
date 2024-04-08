import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../helper/sized.dart';
import '../signIn page/signin_page.dart';
import '../../../../widgets/auth/button_widget.dart';
import 'bloc/sign_up_bloc.dart';
import '../../../../widgets/auth/page_header.dart';
import '../../../../widgets/auth/pass_textfiled.dart';
import '../../../../widgets/auth/text_field_auth.dart';
import '../../../../widgets/auth/text_field_confirm_pass.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key});

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController crController = TextEditingController();
    TextEditingController idController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController confirmPassController = TextEditingController();

    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<SignUpBloc>();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 210),
            child: const PageHeader(
              height: 210,
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
                          textFieldAuth(Controller: crController, label: 'السجل التجاري', obscureText: false,),
                          gapH20,
                          textFieldAuth(Controller: idController, label: "الرقم الوطني الموحد", obscureText: false,),
                          gapH20,
                        PassTextField(controller: passController,),
                          gapH20,
                          TextFieldConfirmPass(confController: confirmPassController, passController: passController),
                          gapH10,
                          Row(
                            children: [
                              Text("موافق على الشروط والأحكام",style: TextStyle(color: blackColor,fontSize: 12),),
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
                                      bloc.add(CreateAccountEvent(
                                        email: emailController.text,
                                        password: passController.text,
                                        name: nameController.text,
                                        cr: crController.text,
                                        id: idController.text,
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
                                              MaterialPageRoute(builder: (context) => SigninPage()),
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









// import 'package:bunya_app/helper/colors.dart';
// import 'package:bunya_app/helper/extintion.dart';
// import 'package:bunya_app/helper/sized.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../widgets/button_widget.dart';
// import '../signin page/sign_in.dart';
// import '../widgets/textfield_widget.dart';
// import 'bloc/sign_up_bloc.dart';
// import 'widget/page_header.dart';

// class SignUpPage extends StatelessWidget {
//   const SignUpPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController nameController = TextEditingController();
//     TextEditingController emailController = TextEditingController();
//     TextEditingController crController = TextEditingController();
//     TextEditingController idController = TextEditingController();
//     TextEditingController passController = TextEditingController();
//         TextEditingController confirmPassController = TextEditingController();

//     return BlocProvider(
//       create: (context) => SignUpBloc(),
//       child: Builder(builder: (context) {
//         final bloc = context.read<SignUpBloc>();
//         return Scaffold(
//           appBar: PreferredSize(
//             preferredSize: Size(context.getWidth(), 280),
//             child: const PageHeader(
//               height: 150,
//               bottomText: "تسجيل حساب",
//             ),
//           ),
//           body: BlocConsumer<SignUpBloc, SignUpState>(
//             listener: (context, state) {
//               if (state is SuccessSignUpState) {
//                //        SignUp Function Here 
                      
               
//               }
//               if (state is ErrorSignUpState) {
//                     //      Error  SignUp Function Here 
                      
//               }
//             },
//             builder: (context, state) {
//               if (state is LoadingSignUpState){
//                 return Center(child: CircularProgressIndicator(
//                   color: green,
//                 ),);
//               }else{
//               return Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: SingleChildScrollView(
//                   child: SizedBox(
//                     height: context.getHeight() * .6,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         TextFieldWidget(
//                           text: "الاسم",
//                           controller: nameController,
//                         ),
//                         TextFieldWidget(
//                           text: "البريد الالكتروني",
//                           controller: emailController,
//                         ),
//                          TextFieldWidget(
//                           text: " السجل التجاري",
//                           controller: crController,
//                         ),
//                          TextFieldWidget(
//                           text: " الرقم الوطني الموحد",
//                           controller: idController,
//                         ),
//                         TextFieldWidget(
//                           text: "كلمة المرور",
//                           controller: passController,
//                           obscure: true,
//                         ),
//                          TextFieldWidget(
//                           text: "تأكيد كلمةالمرور" ,
//                           controller: confirmPassController,
//                           obscure: true,
//                         ),
//                         gapH10,
//                         Column(
//                           children: [
//                             ButtonWidget(
//                               backgroundColor: darkGreen,
//                               text: "تسجيل الحساب",
//                               onPressed: () {
//                                 bloc.add(CreateAccountEvent(
//                                   email: emailController.text,
//                                   password: passController.text,
//                                   name: nameController.text,
//                                   cr: crController.text, 
//                                   id: idController.text,
//                                   confirmPass:confirmPassController.text,
                                   
//                                 ));
//                               },
//                               textColor: whiteColor,
//                             ),
//                             gapH5,
//                             RichText(
//                               text: TextSpan(
//                               children: [
//                                 TextSpan(text: "يوجد لديك حساب؟  ", style: TextStyle(color: blackColor ,fontSize: 20, fontFamily: GoogleFonts.vazirmatn().fontFamily),),
//                                 TextSpan(text: "تسجيل الدخول", style: TextStyle(
//                                         fontSize: 20, color: darkBrown, fontFamily: GoogleFonts.vazirmatn().fontFamily), recognizer: TapGestureRecognizer()..onTap =() {
//                                           context.pushAndRemove(const SignIn());
//                                         })
//                               ]
//                             ),),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//               }
//             },
//           ),
//         );
//       }),
//     );
//   }
// }
