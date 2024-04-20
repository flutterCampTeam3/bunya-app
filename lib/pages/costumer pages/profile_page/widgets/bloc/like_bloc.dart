import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:meta/meta.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  bool isLike = false;
  int number = 0;
  LikeBloc() : super(LikeInitial()) {
    on<LikeEvent>((event, emit) {});
    on<CheckLikeEvent>(checkLike);
    on<AddLikeEvent>(addLike);
    on<DeleteLikeEvent>(deleteLike);
    // on<GetLikeNumberEvent>(likeNumber);
  }

  FutureOr<void> checkLike(
      CheckLikeEvent event, Emitter<LikeState> emit) async {
    emit(LaudLikeState());
    try {
      isLike = await DBService().checkLike(postId: event.id);
      // number = await DBService().getLikeNumber(postId: event.id);
      emit(CheckLikeState());
    } catch (e) {
      print(e.toString());
      emit(ErrorLikeState(msg: 'حدث خطاء في تحميل بيانات الاعجابات'));
    }
  }

  FutureOr<void> addLike(AddLikeEvent event, Emitter<LikeState> emit) async {
    emit(LaudLikeState());
    try {
      print("press the add bottun");
      isLike = await DBService().addLike(postId: event.id);
      // number = await DBService().getLikeNumber(postId: event.id);
      emit(AddLikeState());
    } catch (e) {
      print(e.toString());
      emit(ErrorLikeState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }

  FutureOr<void> deleteLike(
      DeleteLikeEvent event, Emitter<LikeState> emit) async {
    emit(LaudLikeState());
    try {
      isLike = await DBService().deleteLike(postId: event.id);
      // number = await DBService().getLikeNumber(postId: event.id);
      emit(DeleteLikeState());
    } catch (e) {
      print(e.toString());
      emit(ErrorLikeState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }

  // FutureOr<void> likeNumber(
  //     GetLikeNumberEvent event, Emitter<LikeState> emit) async {
  //   try {
  //     number = await DBService().getLikeNumber(postId: event.id);
  //     emit(DeleteLikeState());
  //   } catch (e) {
  //     print(e.toString());
  //     emit(ErrorLikeState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
  //   }
  // }
}
