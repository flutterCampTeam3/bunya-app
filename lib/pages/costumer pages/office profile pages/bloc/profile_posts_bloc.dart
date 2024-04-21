import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../data/model/post_model.dart';
import '../../../../data/service/supabase_services.dart';
part 'profile_posts_event.dart';
part 'profile_posts_state.dart';

class ProfilePostsBloc extends Bloc<ProfilePostsEvent, ProfilePostsState> {
  bool isFollow = true;
  int followerNumber = 0;
  int followingNumber = 0;
  List<postModel> classPostId = [];
  ProfilePostsBloc() : super(ProfilePostsInitial()) {
    on<ShowDataIdEvent>(fetchDataId);
    on<CheckFollowEvent>(checkFollow);
    on<AddFollowEvent>(addFollow);
    on<DeleteFollowEvent>(deleteFollow);
    on<CheckFollowNumberEvent>(checkFollowNumber);
  }
  Future<void> fetchDataId(
      ShowDataIdEvent event, Emitter<ProfilePostsState> emit) async {
    emit(LoadingState());
    try {
      print("in the bloc of post fitch");
      classPostId = await DBService().getPostsId(ofiiceId: event.id);
      print("in the bloc of post after the func");
      emit(profilePostsSuccesState());
    } catch (e) {
      emit(ErrorprofileShowpostState(msg: 'فشل في جلب البيانات '));
    }
  }

  Future<void> checkFollow(
      CheckFollowEvent event, Emitter<ProfilePostsState> emit) async {
    // emit(LoadingFollowState());
    try {
      isFollow = await DBService().checkFollowers(officeID: event.id);
      classPostId = await DBService().getPostsId(ofiiceId: event.id);
      print("in the bloc of post after the func");
      emit(profilePostsSuccesState());
      emit(CheckFollowState());
    } catch (e) {
      print(e.toString());
      emit(ErrorFollowState(msg: 'حدث خطاء في تحميل بيانات الحساب'));
    }
  }

  FutureOr<void> addFollow(
      AddFollowEvent event, Emitter<ProfilePostsState> emit) async {
    // emit(LoadingFollowState());
    try {
      print("press the add bottun");
      isFollow = await DBService().addFollowers(officeID: event.id);
            classPostId = await DBService().getPostsId(ofiiceId: event.id);
      print("in the bloc of post after the func");
      emit(profilePostsSuccesState());
      emit(AddFollowState(msg: 'تم متابعة المستخدم'));
    } catch (e) {
      print(e.toString());
      emit(ErrorFollowState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }

  FutureOr<void> deleteFollow(
      DeleteFollowEvent event, Emitter<ProfilePostsState> emit) async {
    // emit(LoadingFollowState());
    try {
      isFollow = await DBService().deleteFollowers(officeID: event.id);
            classPostId = await DBService().getPostsId(ofiiceId: event.id);
      print("in the bloc of post after the func");
      emit(profilePostsSuccesState());
      emit(DeleteFollowState(msg: 'تم الغاء متابعة المستخدم'));
    } catch (e) {
      print(e.toString());
      emit(ErrorFollowState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }

  FutureOr<void> checkFollowNumber(
      CheckFollowNumberEvent event, Emitter<ProfilePostsState> emit) async {
    // emit(LoadingFollowState());
    try {
      followerNumber =
          await DBService().followerNumber(officeId: event.officeId);
      followingNumber =
          await DBService().followingNumber(customerId: event.officeId);
            classPostId = await DBService().getPostsId(ofiiceId: event.officeId);
      print("in the bloc of post after the func");
      emit(profilePostsSuccesState());
    } catch (e) {
      print(e.toString());
      emit(ErrorFollowState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }
}
