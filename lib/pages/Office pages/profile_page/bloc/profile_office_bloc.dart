import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/profile_model_office.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/post_model.dart';

part 'profile_office_event.dart';
part 'profile_office_state.dart';

class ProfileOfficeBloc extends Bloc<ProfileOfficeEvent, ProfileOfficeState> {
     List<postModel> classPostId = [];
  final locator = GetIt.I.get<DBService>();
  // String? description;
  // String? email;
  // int? phone;
  // String? address;
  ProfileOfficeBloc() : super(ProfileOfficeInitial()) {
    //  on<ActivateEditModeEvent>(activateEditMode);
    // on<DeactivateEditModeEvent>(deactivateEditMode);
    on<GetOfficeInfoEvent>(getOfficeInfo);
    // on<UpdateUserInfoEvent>(updateUserInfo);
    // on<SignOutEvent>(signOut);
    on<ShowDataOfficesIdEvent>(fetchDataId);
    on<ProfileOfficeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }


Future<void> fetchDataId(
      ShowDataOfficesIdEvent event, Emitter<ProfileOfficeState> emit) async {
    emit(LoadingState());
    try {
      // List<postModel> postList =
      //     await DBService().getPostsId(ofiiceId: event.id);
      classPostId = await DBService().getPostsId(ofiiceId: event.id);


      emit(profilePostsSuccesState());
    } catch (e) {
      emit(ProfileOfficeErrorState(msg: 'فشل في جلب البيانات '));
    }
  }

  Future<FutureOr<void>> getOfficeInfo(
      GetOfficeInfoEvent event, Emitter<ProfileOfficeState> emit) async {
    print("in the bloc get");
    emit(ProfileLoadingState());
    try {
      print("in the try");
      final ProfileOfficeModel profile = await locator.getOffice();
      print("after");
      final email = profile.email;
      final name = profile.name;
      final phone = profile.phone;
      final image = profile.image;
      final descriptionn = profile.description;
      emit(DisplayOfficeInfoState(
          image: image,
          name: name,
          email: email,
          phone: phone,
          description: descriptionn));
    } catch (e) {
      print("in catch");
      print(e.toString());
      emit(ProfileOfficeErrorState(
          msg: "حدث خطأ عند تحميل بياناتك يرجى المحاولة لاحقاً"));
    }
  }
}
