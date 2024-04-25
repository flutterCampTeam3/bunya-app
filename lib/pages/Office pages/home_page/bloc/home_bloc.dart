import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/post_model.dart';
import 'package:bunya_app/data/service/supabase%20services/services.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/offices_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeOfficesBloc extends Bloc<HomeOfficesEvent, HomeOfficesState> {
  bool isHomeLike = false;
  List<postModel> classPost = [];
  List<OfficesModel> officeList = [];
  int likeNumber = 0;
  HomeOfficesBloc() : super(HomeInitial()) {
    // on<ShowImageEvent>(fetchPosts);
    on<ShowDataOfficesEvent>(fetchData);
    on<CheckLikeHomeOfficesEvent>(checkHomeLike);
    on<AddLikeHomeOfficesEvent>(addHomeLike);
    on<DeleteLikeHomeOfficesEvent>(deleteHomeLike);
  }

  Future<void> fetchData(
      ShowDataOfficesEvent event, Emitter<HomeOfficesState> emit) async {
    emit(LoadingState());
    try {
      officeList = await DBService().getOffices();
      classPost = await DBService().getposts();
      emit(datahomeSuccesOfficesState());
    } catch (e) {
      emit(ErrorOfficesState(msg: 'فشل في جلب البيانات '));
    }
  }

  FutureOr<void> checkHomeLike(
      CheckLikeHomeOfficesEvent event, Emitter<HomeOfficesState> emit) async {
    emit(LaudLikeHomeOfficesState());
    try {
      print("in the bloc of home like the val: $isHomeLike");
      isHomeLike = await DBService().checkLike(postId: event.id);
      print("in the bloc of home like the val: $isHomeLike");
      likeNumber = await DBService().getLikeNumber(postId: event.id);
      emit(CheckLikeHomeOfficesState());
    } catch (e) {
      print(e.toString());
      emit(
          ErrorLikeHomeOfficesState(msg: 'حدث خطاء في تحميل بيانات الاعجابات'));
    }
  }

  FutureOr<void> addHomeLike(
      AddLikeHomeOfficesEvent event, Emitter<HomeOfficesState> emit) async {
    emit(LaudLikeHomeOfficesState());
    try {
      isHomeLike = await DBService().addLike(post: event.post);
      likeNumber = await DBService().getLikeNumber(postId: event.post.postId);
      emit(AddLikeHomeOfficesState());
    } catch (e) {
      print(e.toString());
      emit(ErrorLikeHomeOfficesState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }

  FutureOr<void> deleteHomeLike(
      DeleteLikeHomeOfficesEvent event, Emitter<HomeOfficesState> emit) async {
    emit(LaudLikeHomeOfficesState());
    try {
      isHomeLike = await DBService().deleteLike(postId: event.id);
      likeNumber = await DBService().getLikeNumber(postId: event.id);
      emit(DeleteLikeHomeOfficesState());
    } catch (e) {
      print(e.toString());
      emit(ErrorLikeHomeOfficesState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }
}
