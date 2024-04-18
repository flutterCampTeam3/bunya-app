import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/post_model.dart';
import '../../../../data/service/supabase_services.dart';

part 'profile_posts_event.dart';
part 'profile_posts_state.dart';

class ProfilePostsBloc extends Bloc<ProfilePostsEvent, ProfilePostsState> {
  ProfilePostsBloc() : super(ProfilePostsInitial()) {
  on<ShowDataIdEvent>(fetchDataId);
  }
    Future<void> fetchDataId(ShowDataIdEvent event, Emitter<ProfilePostsState> emit) async {
    emit (LoadingState());
    try {
      
      List<postModel> postList = await DBService().getPostsId(ofiiceId: event.id);
      
      emit(profilePostsSuccesState(classPostId:postList ));
    } catch (e) {
        emit(ErrorprofileShowpostState(msg: 'فشل في جلب البيانات '));
    }
  }
}
