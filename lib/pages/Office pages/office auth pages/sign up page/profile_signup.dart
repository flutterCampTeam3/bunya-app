import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/pages/Office%20pages/office%20auth%20pages/sign%20up%20page/widgets/image_piker_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../helper/sized.dart';
import '../../../widgets/auth/button_widget.dart';
import '../signIn page/signin_page.dart';
import 'bloc/sign_up_bloc.dart';
import 'widgets/profile_text_field_auth.dart';
import 'widgets/type_dropdown_Container_widget.dart';
import 'widgets/page_header.dart';

import 'package:image_picker/image_picker.dart';

class ProfileSignup extends StatefulWidget {
  const ProfileSignup(
      {super.key,
      Key,
      required this.name,
      required this.cr,
      required this.pass,
      required this.email});
  final String name;
  final String cr;
  final String email;
  final String pass;

  @override
  State<ProfileSignup> createState() => _ProfileSignupState();
}

class _ProfileSignupState extends State<ProfileSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    late TextEditingController infoController = TextEditingController();
    late TextEditingController locationController = TextEditingController();
    late TextEditingController phoneController = TextEditingController();

    @override
    void initState() {
      super.initState();
      infoController = TextEditingController();
      locationController = TextEditingController();
      phoneController = TextEditingController();
    }

    @override
    void dispose() {
      infoController.dispose();
      locationController.dispose();
      phoneController.dispose();
      super.dispose();
    }

    Future<void> pickImage() async {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      // Handle the pickedImage here
    }

    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<SignUpBloc>();
        return Scaffold(
          backgroundColor: freewhiteBrown,
          appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 210),
            child: const PageHeader(
              
              height: 210,
              bottomText: " ادخل بيانات ملفك الشخصي",
              
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
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .7,
                    child: ListView(
                      children: [
                        gapH10, 
                         
                        const ImagePickerWidget(),                  
                       
                        gapH20,
                        const TypeDropDownWidget(),
                        gapH20,
                        ProfiletextFieldAuth(
                          Controller: infoController,
                          label: 'معلومات عن الشركة  ',
                          obscureText: false,
                        ),
                        gapH20,
                        ProfiletextFieldAuth(
                          Controller: locationController,
                          label: ' عنوان الشركة  ',
                          obscureText: false,
                        ),
                        gapH20,
                        ProfiletextFieldAuth(
                          Controller: phoneController,
                          label: 'رقم الجوال',
                          obscureText: false,
                          phone: true,
                        ),                 
                       
                        
                        gapH10,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ButtonWidget(
                                backgroundColor: darkBrown,
                                text: "  حفظ",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    bloc.add(CreateAccountprofileEvent(
                                      info: infoController.text,
                                      location: locationController.text,
                                      phone: phoneController.text,
                                      cr: widget.cr,
                                      email: widget.email,
                                      name: widget.name,
                                      departmentId: bloc.type,
                                      password: widget.pass,
                                    ));
                                  }
                                },
                                textColor: Colors.white,
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
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
