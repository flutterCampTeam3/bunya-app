import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/post_model.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/offices_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeOfficesBloc extends Bloc<HomeOfficesEvent, HomeOfficesState> {
  HomeOfficesBloc() : super(HomeInitial()) {
    // on<ShowImageEvent>(fetchPosts);
    on<ShowDataOfficesEvent>(fetchData);
  }

  // Future<void> fetchPosts(ShowImageEvent event, Emitter<HomeState> emit) async {
  //   emit (LoadingState());
  //   try {
  //     List<postModel> postList = await DBService().getposts();
     
  //     emit(postsSuccesState(classPost: postList));
  //   } catch (e) {
  //       emit(ErrorShowpostState(msg: 'فشل في جلب بيانات المنشورات'));
  //   }
  // }

   Future<void> fetchData(ShowDataOfficesEvent event, Emitter<HomeOfficesState> emit) async {
    emit (LoadingState());
    try {
      List<OfficesModel> officeList = await DBService().getOffices();
      List<postModel> postList = await DBService().getposts();
      
      emit(datahomeSuccesOfficesState(classOffices: officeList, classPost:postList ));
    } catch (e) {
        emit(ErrorOfficesState(msg: 'فشل في جلب البيانات '));
    }
  }

  
}
