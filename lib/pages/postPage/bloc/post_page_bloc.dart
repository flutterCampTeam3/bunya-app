import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/post_model.dart';

part 'post_page_event.dart';
part 'post_page_state.dart';

class PostPageBloc extends Bloc<PostPageEvent, PostPageState> {
   bool isFollow = false;
  PostPageBloc() : super(PostPageInitial()) {
   on<ShowPostDataIdEvent>(fetchPostDataId);
    // on<CheckPostFollowEvent>(checkFollow);
  }
   Future<void> fetchPostDataId(
      ShowPostDataIdEvent event, Emitter<PostPageState> emit) async {
    emit(LoadingPostState());
    try {
      List<postModel> postList =
          await DBService().getPostsId(ofiiceId: event.id);
      emit(PostsSuccesState(classPostId: postList));
    } catch (e) {
      emit(ErrorPostShowpostState(msg: 'فشل في جلب البيانات '));
    }
  }

   Future<void> checkFollow(
      CheckPostFollowEvent event, Emitter<PostPageState> emit) async {
    emit(LoadingPostState());
    try {
      isFollow = await DBService().checkFollowers(officeID: event.id);
      emit(CheckPostFollow());
    } catch (e) {
      emit(ErrorPostShowpostState(msg: 'لم يتم ايجاد الحسابات'));
    }
  }
}
