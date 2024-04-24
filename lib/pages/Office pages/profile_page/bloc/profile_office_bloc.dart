import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/post_model.dart';
import 'package:bunya_app/data/model/profile_model_office.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:bunya_app/pages/costumer%20pages/profile_page/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import '../../../../data/model/offices_model.dart';
part 'profile_office_event.dart';
part 'profile_office_state.dart';

class ProfileOfficeBloc extends Bloc<ProfileOfficeEvent, ProfileOfficeState> {
  List<postModel> classPostId = [];
  final locator = GetIt.I.get<DBService>();
  int followerNumber = 0;
  int followingNumber = 0;
  int likesNumber = 0;
  bool isLike = false;
  int number = 0;
  late ProfileOfficeModel profile;
  ProfileOfficeBloc() : super(ProfileOfficeInitial()) {
    on<ActivateEditModeOfficeEvent>(activateEditMode);
    on<DeactivateEditModeOfficeEvent>(deactivateEditMode);
    on<GetOfficeInfoOfficeEvent>(getOfficeInfo);
    on<UpdateOfficeInfoOfficeEvent>(updateUserInfo);
    on<SignOutOfficeEvent>(signOut);
    on<CheckFollowNumberOfOfficeEvent>(checkFollowNumber);
    on<ProfileOfficeEvent>((event, emit) {});
    on<CheckLikeOfficeEvent>(checkLike);
    on<AddLikeOfficeEvent>(addLike);
    on<DeleteLikeOfficeEvent>(deleteLike);
  }

  Future<void> fetchFllowers(
      ShowFloowersEvent event, Emitter<ProfileOfficeState> emit) async {
    emit(ProfileLoadingState());
    try {
      List<OfficesModel> officeList =
          await DBService().followingNumber(customerId: event.id);
      emit(dataFlowrsSuccesState(classOffices: officeList));
    } catch (e) {
      emit(ProfileOfficeErrorState(msg: ""));
    }
  }

  Future<FutureOr<void>> getOfficeInfo(
      GetOfficeInfoOfficeEvent event, Emitter<ProfileOfficeState> emit) async {
    emit(ProfileLoadingState());
    try {
      profile = await locator.getOffice();
      classPostId = await locator.getPostsOffficeId();
      emit(DisplayOfficeInfoState());
    } catch (e) {
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

  FutureOr<void> activateEditMode(
      ActivateEditModeOfficeEvent event, Emitter<ProfileOfficeState> emit) {
    emit(ActivatedEditModeOfficeState(
      email: locator.email,
      name: locator.name,
    ));
  }

  FutureOr<void> deactivateEditMode(DeactivateEditModeOfficeEvent event,
      Emitter<ProfileOfficeState> emit) async {
    emit(DeactivatedEditModeOfficeState());
    await getOfficeInfo(GetOfficeInfoOfficeEvent(), emit);
  }

  FutureOr<void> updateUserInfo(UpdateOfficeInfoOfficeEvent event,
      Emitter<ProfileOfficeState> emit) async {
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
      emit(ProfileOfficeErrorState(msg: "الرجاء ادخال جميع البيانات"));
    }
  }

  FutureOr<void> checkLike(
      CheckLikeOfficeEvent event, Emitter<ProfileOfficeState> emit) async {
    emit(LaudLikeOfficeState());
    try {
      isLike = await DBService().checkLike(postId: event.id);
      number = await DBService().getLikeNumber(postId: event.id);
      checkFollowNumber(CheckFollowNumberOfOfficeEvent(), emit);
      emit(CheckLikeOfficeState());
      emit(DisplayOfficeInfoState());
    } catch (e) {
      print(e.toString());
      emit(ErrorLikeOfficeState(msg: 'حدث خطاء في تحميل بيانات الاعجابات'));
    }
  }

  FutureOr<void> addLike(
      AddLikeOfficeEvent event, Emitter<ProfileOfficeState> emit) async {
    emit(LaudLikeOfficeState());
    try {
      isLike = await DBService().addLike(post: event.post);
      number = await DBService().getLikeNumber(postId: event.post.postId);
      checkFollowNumber(CheckFollowNumberOfOfficeEvent(), emit);
      emit(AddLikeOfficeState());
      emit(DisplayOfficeInfoState());
    } catch (e) {
      print(e.toString());
      emit(ErrorLikeOfficeState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }

  FutureOr<void> deleteLike(
      DeleteLikeOfficeEvent event, Emitter<ProfileOfficeState> emit) async {
    emit(LaudLikeOfficeState());
    try {
      isLike = await DBService().deleteLike(postId: event.id);
      number = await DBService().getLikeNumber(postId: event.id);
      checkFollowNumber(CheckFollowNumberOfOfficeEvent(), emit);
      emit(DeleteLikeOfficeState());
      emit(DisplayOfficeInfoState());
    } catch (e) {
      print(e.toString());
      emit(ErrorLikeOfficeState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }
}
