import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final locator = GetIt.I.get<DBService>();
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
    emit(ActivatedEditModeState());
  }

  Future<FutureOr<void>> deactivateEditMode(
      DeactivateEditModeEvent event, Emitter<ProfileState> emit) async {
    emit(DeactivatedEditModeState());
    await getUserInfo(GetUserInfoEvent(), emit);
  }

  Future<FutureOr<void>> getUserInfo(
      GetUserInfoEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      locator.email = locator.supabase.auth.currentUser!.email!;
      locator.name = await locator.getUserName();
      emit(DisplayUserInfoState(
        email: locator.email,
        name: locator.name,
      ));
    } catch (e) {
      emit(ProfileErrorState(
          msg: "حدث خطأ عند تحميل بياناتك يرجى المحاولة لاحقاً"));
    }
  }

  Future<FutureOr<void>> updateUserInfo(
      UpdateUserInfoEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    if (event.name.trim().isNotEmpty) {
      try {
        await locator.updateUserName(newName: event.name);
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
