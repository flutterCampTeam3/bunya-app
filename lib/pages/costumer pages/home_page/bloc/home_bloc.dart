import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/post_model.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/offices_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool isHomeLike = false;
  int likeNumber = 0;
  HomeBloc() : super(HomeInitial()) {
    // on<ShowImageEvent>(fetchPosts);
    on<ShowDataEvent>(fetchData);
    on<CheckLikeHomeEvent>(checkHomeLike);
    on<AddLikeHomeEvent>(addHomeLike);
    on<DeleteLikeHomeEvent>(deleteHomeLike);
  }

  Future<void> fetchData(ShowDataEvent event, Emitter<HomeState> emit) async {
    emit(LoadingState());
    try {
      List<OfficesModel> officeList = await DBService().getOffices();
      List<postModel> postList = await DBService().getposts();
      emit(datahomeSuccesState(classOffices: officeList, classPost: postList));
    } catch (e) {
      emit(ErrorShowpostState(msg: 'فشل في جلب البيانات '));
    }
  }

  FutureOr<void> checkHomeLike(
      CheckLikeHomeEvent event, Emitter<HomeState> emit) async {
    emit(LaudLikeHomeState());
    try {
      print("in the bloc of home like the val: $isHomeLike");
      isHomeLike = await DBService().checkLike(postId: event.id);
      print("in the bloc of home like the val: $isHomeLike");
      likeNumber = await DBService().getLikeNumber(postId: event.id);
      emit(CheckLikeHomeState());
    } catch (e) {
      print(e.toString());
      emit(ErrorLikeHomeState(msg: 'حدث خطاء في تحميل بيانات الاعجابات'));
    }
  }

  FutureOr<void> addHomeLike(
      AddLikeHomeEvent event, Emitter<HomeState> emit) async {
    emit(LaudLikeHomeState());
    try {
      isHomeLike = await DBService().addLike(postId: event.id);
      likeNumber = await DBService().getLikeNumber(postId: event.id);
      emit(AddLikeHomeState());
    } catch (e) {
      print(e.toString());
      emit(ErrorLikeHomeState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }

  FutureOr<void> deleteHomeLike(
      DeleteLikeHomeEvent event, Emitter<HomeState> emit) async {
    emit(LaudLikeHomeState());
    try {
      isHomeLike = await DBService().deleteLike(postId: event.id);
      likeNumber = await DBService().getLikeNumber(postId: event.id);
      emit(DeleteLikeHomeState());
    } catch (e) {
      print(e.toString());
      emit(ErrorLikeHomeState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }
}
