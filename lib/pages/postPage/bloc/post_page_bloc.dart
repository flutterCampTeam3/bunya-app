import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:meta/meta.dart';
part 'post_page_event.dart';
part 'post_page_state.dart';

class PostPageBloc extends Bloc<PostPageEvent, PostPageState> {
  bool isFollow = false;
  bool isHomeLike = false;
  int likeNumber = 0;
  PostPageBloc() : super(PostPageInitial()) {
    on<CheckPostFollowEvent>(checkPostFollow);
    on<CheckLikePostEvent>(checkPostLike);
    on<AddLikePostEvent>(addPostLike);
    on<DeleteLikePostEvent>(deletePostLike);
    on<AddFollowPostEvent>(addPostFollow);
    on<DeleteFollowPostEvent>(deletePostFollow);
  }

  FutureOr<void> checkPostLike(
      CheckLikePostEvent event, Emitter<PostPageState> emit) async {
    try {
      print("in the bloc of home like the val: $isHomeLike");
      isHomeLike = await DBService().checkLike(postId: event.id);
      print("in the bloc of home like the val: $isHomeLike");
      likeNumber = await DBService().getLikeNumber(postId: event.id);
      emit(CheckLikePostState());
      emit(PostsSuccesState());
    } catch (e) {
      print(e.toString());
      emit(ErrorPostShowpostState(msg: 'حدث خطاء في تحميل بيانات الاعجابات'));
    }
  }

  FutureOr<void> addPostLike(
      AddLikePostEvent event, Emitter<PostPageState> emit) async {
    try {
      isHomeLike = await DBService().addLike(postId: event.id);
      likeNumber = await DBService().getLikeNumber(postId: event.id);
      emit(AddLikePostState());
      emit(PostsSuccesState());
    } catch (e) {
      print(e.toString());
      emit(ErrorPostShowpostState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }

  FutureOr<void> deletePostLike(
      DeleteLikePostEvent event, Emitter<PostPageState> emit) async {
    try {
      isHomeLike = await DBService().deleteLike(postId: event.id);
      likeNumber = await DBService().getLikeNumber(postId: event.id);
      emit(DeleteLikePostState());
      emit(PostsSuccesState());
    } catch (e) {
      print(e.toString());
      emit(ErrorPostShowpostState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }

  FutureOr<void> checkPostFollow(
      CheckPostFollowEvent event, Emitter<PostPageState> emit) async {
    try {
      isFollow = await DBService().checkFollowers(officeID: event.id);
      emit(CheckPostFollow());
      emit(PostsSuccesState());
    } catch (e) {
      emit(ErrorPostShowpostState(msg: 'لم يتم ايجاد الحسابات'));
    }
  }

  FutureOr<void> addPostFollow(
      AddFollowPostEvent event, Emitter<PostPageState> emit) async {
    try {
      print("press the add bottun");
      isFollow = await DBService().addFollowers(officeID: event.id);
      emit(AddFollowPostState(msg: 'تم متابعة المستخدم'));
      emit(PostsSuccesState());
    } catch (e) {
      print(e.toString());
      emit(ErrorPostShowpostState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }

  FutureOr<void> deletePostFollow(
      DeleteFollowPostEvent event, Emitter<PostPageState> emit) async {
    try {
      isFollow = await DBService().deleteFollowers(officeID: event.id);
      emit(DeleteFollowPostState(msg: 'تم الغاء متابعة المستخدم'));
      emit(PostsSuccesState());
    } catch (e) {
      print(e.toString());
      emit(ErrorPostShowpostState(msg: 'حدث خطا يرجي المحاولة مرة اخرى'));
    }
  }
}
