import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/service/supabase%20services/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBlocCustomer
    extends Bloc<SignUpCustomerEvent, SignUpCustomerState> {
  SignUpBlocCustomer() : super(SignUpInitial()) {
    final locator = GetIt.I.get<DBService>();
    on<CreateAccountCustomerEvent>(createAccount);
    on<CustomerChoosImageEvent>((event, emit) async {
      File avatar = File(await pickedImage());
      locator.coustomerImageFile = avatar;
      emit(CustomerChoosImageEventShowImageState(avatar));
    });

    on<UploadProfileImage>((event, emit) async {
      locator.uploadProfileImage(
          locator.coustomerImageFile, event.bucketName, event.fileName);

      locator.imageId = await locator.UrlImage(event.fileName);
    });
  }
//-----------------------
  Future pickedImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);

    return (img!.path);
  }

  Future<void> createAccount(CreateAccountCustomerEvent event,
      Emitter<SignUpCustomerState> emit) async {
    final locator = GetIt.I.get<DBService>();
    locator.uploadProfileImage(
        locator.coustomerImageFile, event.bucketName, event.fileName);
    String imageUrl = await locator.UrlImage(event.fileName);

    print("----> url $imageUrl");

    if (event.name.trim().isNotEmpty &&
        event.email.trim().isNotEmpty &&
        event.password.trim().isNotEmpty &&
        event.phone.trim().isNotEmpty &&
        event.confirmPass.trim().isNotEmpty &&
        imageUrl.isNotEmpty) {
      try {
        emit(LoadingSignUpCustomerState());
        print("befor signup");
        await DBService().signUpC(
            image: imageUrl,
            phoneNumber: event.phone,
            userName: event.name,
            email: event.email,
            password: event.password);
        emit(SuccessSignUpCustomerState(msg: "تم إنشاء الحساب بنجاح"));
      } catch (error) {
        print("error");
        emit(ErrorSignUpCustomerState(msg: "هناك خطأ في إنشاء الحساب"));
      }
    } else {
      emit(ErrorSignUpCustomerState(msg: "الرجاء إدخال جميع القيم"));
    }
  }
}
