import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/pages/Office%20pages/office%20auth%20pages/sign%20up%20page/signup_page.dart';
import 'package:bunya_app/pages/Office%20pages/office%20auth%20pages/sign%20up%20page/widgets/image_piker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../helper/sized.dart';
import '../../../widgets/auth/button_widget.dart';
import 'bloc/sign_up_bloc.dart';
import 'widgets/profile_text_field_auth.dart';
import 'widgets/type_dropdown_Container_widget.dart';
import 'widgets/page_header.dart';

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
    String imageId = const Uuid().v4();

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

    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<SignUpBloc>();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 210),
              child: Stack(
                children: [
                  const PageHeader(
                    height: 210,
                    bottomText: "ادخل بيانات ملفك الشخصي",
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () {
                        context.pushTo(view: const SignUpPage());
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: blackColor,
                    ),
                  ),
                ],
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
                                        bucketName: "profile",
                                        fileName: imageId,
                                      ));
                                      bloc.add(UploadProfileOfficeImage(
                                          bucketName: "profile",
                                          fileName: imageId));
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
          ),
        );
      }),
    );
  }
}
