import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/profile_model_customer.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final locator = GetIt.I.get<DBService>();
  String? name;
  String? email;
  int? phone;
  ProfileBloc() : super(ProfileInitial()) {
    on<ActivateEditModeEvent>(activateEditMode);
    on<DeactivateEditModeEvent>(deactivateEditMode);
    on<GetUserInfoEvent>(getUserInfo);
    on<UpdateUserInfoEvent>(updateUserInfo);
    on<SignOutEvent>(signOut);
    on<ProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  FutureOr<void> activateEditMode(
      ActivateEditModeEvent event, Emitter<ProfileState> emit) {
    emit(ActivatedEditModeState(
      email: locator.email,
      name: locator.name,
    ));
  }

  Future<FutureOr<void>> deactivateEditMode(
      DeactivateEditModeEvent event, Emitter<ProfileState> emit) async {
    emit(DeactivatedEditModeState());
    await getUserInfo(GetUserInfoEvent(), emit);
  }

  Future<FutureOr<void>> getUserInfo(
      GetUserInfoEvent event, Emitter<ProfileState> emit) async {
    print("in the bloc");
    emit(ProfileLoadingState());
    try {
      print("in the try");
      final ProfileModel profile = await locator.getUser();
      print("after");
      final email = profile.email;
      final name = profile.name;
      final phone = profile.phone;
      emit(DisplayUserInfoState(name: name, email: email, phone: phone));
    } catch (e) {
      print(e.toString());
      emit(ProfileErrorState(
          msg: "حدث خطأ عند تحميل بياناتك يرجى المحاولة لاحقاً"));
    }
  }

  Future<FutureOr<void>> updateUserInfo(
      UpdateUserInfoEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    if (event.name.trim().isNotEmpty) {
      try {
        await locator.editUpdate(
            name: event.name, email: event.email, phone: event.phone);
        await getUserInfo(GetUserInfoEvent(), emit);
      } catch (e) {
        emit(ProfileErrorState(msg: "هناك خطأ في عملية تحديث بياناتك"));
      }
    } else {
      emit(ProfileErrorState(msg: "يرجى عدم ترك حقل الاسم فارغاً"));
    }
  }

  Future<FutureOr<void>> signOut(
      SignOutEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());

    try {
      await locator.signOut();
      emit(SignedOutState(msg: "تم تسجيل الخروج من حسابك"));
    } catch (e) {
      emit(ProfileErrorState(msg: "هناك خطأ في عملية تسجيل خروجك"));
    }
  }
}
