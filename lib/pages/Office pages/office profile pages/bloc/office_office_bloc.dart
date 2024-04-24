import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/post_model.dart';
import 'package:bunya_app/data/model/room_model.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:meta/meta.dart';

part 'office_office_event.dart';
part 'office_office_state.dart';

class OfficeOfficeBloc extends Bloc<OfficeOfficeEvent, OfficeOfficeState> {
  bool isFollow = true;
  int followerNumber = 0;
  int followingNumber = 0;
  int likesNumber = 0;
  Room? room;

  List<postModel> classPostId = [];
  OfficeOfficeBloc() : super(OfficeOfficeInitial()) {
    on<OfficeOfficeEvent>((event, emit) {});
    on<ShowDataIdOfficeEvent>(fetchDataId);
    on<CheckFollowOfficeEvent>(checkFollow);
    on<AddFollowOfficeEvent>(addFollow);
    on<DeleteFollowOfficeEvent>(deleteFollow);
    on<CheckFollowNumberOfficeEvent>(checkFollowNumber);
    on<CheckRoomOfficeEvent>(checkRoom);

  }

  FutureOr<void> fetchDataId(
      ShowDataIdOfficeEvent event, Emitter<OfficeOfficeState> emit) async {
    emit(LoadingOfficeState());
    try {
      classPostId = await DBService().getPostsId(ofiiceId: event.id);
      followerNumber = await DBService().followerNumber(officeId: event.id);
      followingNumber = await DBService().followingNumber(customerId: event.id);
      likesNumber = await DBService().getOfficeLikeNumber(officeId: event.id);
      emit(profilePostsSuccesOfficeState());
    } catch (e) {
      emit(ErrorprofileShowpostOfficeState(msg: 'فشل في جلب البيانات '));
    }
  }

  FutureOr<void> checkFollow(
      CheckFollowOfficeEvent event, Emitter<OfficeOfficeState> emit) async {
            try {
      isFollow = await DBService().checkFollowers(officeID: event.id);
      classPostId = await DBService().getPostsId(ofiiceId: event.id);
      followerNumber = await DBService().followerNumber(officeId: event.id);
      followingNumber = await DBService().followingNumber(customerId: event.id);
      likesNumber = await DBService().getOfficeLikeNumber(officeId: event.id);
      print("the bloc after the func ${likesNumber}");
      emit(profilePostsSuccesOfficeState());
      emit(CheckFollowOfficeState());
    } catch (e) {
      print(e.toString());
      emit(ErrorFollowOfficeState(msg: 'حدث خطاء في تحميل بيانات الحساب'));
    }
      }

  FutureOr<void> addFollow(
      AddFollowOfficeEvent event, Emitter<OfficeOfficeState> emit) async {
            try {
      print("press the add bottun");
      isFollow = await DBService().addFollowers(officeID: event.id);
      classPostId = await DBService().getPostsId(ofiiceId: event.id);
      followerNumber = await DBService().followerNumber(officeId: event.id);
      followingNumber = await DBService().followingNumber(customerId: event.id);
      likesNumber = await DBService().getOfficeLikeNumber(officeId: event.id);
      emit(profilePostsSuccesOfficeState());
      emit(AddFollowOfficeState(msg: 'تم متابعة المستخدم'));
    } catch (e) {
      print(e.toString());
      emit(ErrorFollowOfficeState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
      }

  FutureOr<void> deleteFollow(
      DeleteFollowOfficeEvent event, Emitter<OfficeOfficeState> emit) async {
            try {
      isFollow = await DBService().deleteFollowers(officeID: event.id);
      classPostId = await DBService().getPostsId(ofiiceId: event.id);
      followerNumber = await DBService().followerNumber(officeId: event.id);
      followingNumber = await DBService().followingNumber(customerId: event.id);
      likesNumber = await DBService().getOfficeLikeNumber(officeId: event.id);
      emit(profilePostsSuccesOfficeState());
      emit(DeleteFollowOfficeState(msg: 'تم الغاء متابعة المستخدم'));
    } catch (e) {
      print(e.toString());
      emit(ErrorFollowOfficeState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
      }

  FutureOr<void> checkFollowNumber(CheckFollowNumberOfficeEvent event,
      Emitter<OfficeOfficeState> emit) async {
            try {
      followerNumber =
          await DBService().followerNumber(officeId: event.officeId);
      followingNumber =
          await DBService().followingNumber(customerId: event.officeId);
      classPostId = await DBService().getPostsId(ofiiceId: event.officeId);
      likesNumber =
          await DBService().getOfficeLikeNumber(officeId: event.officeId);
      print("in the bloc of post after the func");
      emit(profilePostsSuccesOfficeState());
    } catch (e) {
      print(e.toString());
      emit(ErrorFollowOfficeState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
      }
  FutureOr<void> checkRoom(
      CheckRoomOfficeEvent event,  emit) async {
    // emit(LoadingFollowState());
    try {
      room = await DBService().checkRoom(event.officeId);
      print("in the bloc of chat create");
      emit(CheckChatOfficeState(room: room!));
    } catch (e) {
      print(e.toString());
      emit(ErrorFollowOfficeState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }

}
