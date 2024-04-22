import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/profile_model_office.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/post_model.dart';

part 'profile_office_event.dart';
part 'profile_office_state.dart';

class ProfileOfficeBloc extends Bloc<ProfileOfficeEvent, ProfileOfficeState> {
  List<postModel> classPostId = [];
  final locator = GetIt.I.get<DBService>();
  int followerNumber = 0;
  int followingNumber = 0;
  int likesNumber = 0;
  late ProfileOfficeModel profile;
  ProfileOfficeBloc() : super(ProfileOfficeInitial()) {
    on<ActivateEditModeOfficeEvent>(activateEditMode);
    on<DeactivateEditModeOfficeEvent>(deactivateEditMode);
    on<GetOfficeInfoOfficeEvent>(getOfficeInfo);
    on<UpdateOfficeInfoOfficeEvent>(updateUserInfo);
    on<SignOutOfficeEvent>(signOut);
    on<ShowDataOfficesIdEvent>(fetchDataId);
    on<CheckFollowNumberOfOfficeEvent>(checkFollowNumber);
    on<ProfileOfficeEvent>((event, emit) {});
  }

  Future<void> fetchDataId(
      ShowDataOfficesIdEvent event, Emitter<ProfileOfficeState> emit) async {
    // emit(LoadingState());
    emit(ProfileLoadingState());
    try {
      print("in the bloc of profile");
      classPostId = await DBService().getPostsOffficeId();
      emit(profilePostsSuccesState());
    } catch (e) {
      emit(ProfileOfficeErrorState(msg: 'فشل في جلب البيانات '));
    }
  }

  Future<FutureOr<void>> getOfficeInfo(
      GetOfficeInfoOfficeEvent event, Emitter<ProfileOfficeState> emit) async {
    print("in the bloc get");
    emit(ProfileLoadingState());
    try {
      profile = await locator.getOffice();
      emit(DisplayOfficeInfoState());
    } catch (e) {
      print("in catch");
      print(e.toString());
      emit(ProfileOfficeErrorState(
          msg: "حدث خطأ عند تحميل بياناتك يرجى المحاولة لاحقاً"));
    }
  }

  FutureOr<void> checkFollowNumber(CheckFollowNumberOfOfficeEvent event,
      Emitter<ProfileOfficeState> emit) async {
    try {
      followerNumber = await DBService().followerOfficeNumber();
      followingNumber = await DBService().followingOfficeNumber();
      likesNumber = await DBService().getOfficeLikeOfficeNumber();
      print("in the bloc of post after the func");
      emit(DisplayOfficeInfoState());
    } catch (e) {
      print(e.toString());
      emit(ProfileOfficeErrorState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }

  Future<FutureOr<void>> signOut(
      SignOutOfficeEvent event, Emitter<ProfileOfficeState> emit) async {
    emit(ProfileLoadingState());
    try {
      await locator.signOut();
      emit(SignedOutState(msg: "تم تسجيل الخروج من حسابك"));
    } catch (e) {
      emit(ProfileOfficeErrorState(msg: "هناك خطأ في عملية تسجيل خروجك"));
    }
  }

  FutureOr<void> activateEditMode(ActivateEditModeOfficeEvent event, Emitter<ProfileOfficeState> emit) {
    emit(ActivatedEditModeOfficeState(
      email: locator.email,
      name: locator.name,
    ));
  }

  FutureOr<void> deactivateEditMode(DeactivateEditModeOfficeEvent event, Emitter<ProfileOfficeState> emit) async {
    emit(DeactivatedEditModeOfficeState());
    await getOfficeInfo(GetOfficeInfoOfficeEvent(), emit);
  }

  FutureOr<void> updateUserInfo(UpdateOfficeInfoOfficeEvent event, Emitter<ProfileOfficeState> emit) async{
    emit(ProfileLoadingState());
    if (event.name.trim().isNotEmpty) {
      try {
        await locator.editUpdate(
            name: event.name, email: event.email, phone: event.phone);
        await getOfficeInfo(GetOfficeInfoOfficeEvent(), emit);
      } catch (e) {
        emit(ProfileOfficeErrorState(msg: "هناك خطأ في عملية تحديث بياناتك"));
      }
    } else {
      emit(ProfileOfficeErrorState(msg: "يرجى عدم ترك حقل الاسم فارغاً"));
    }
  }
}
