import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/profile_model_office.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'profile_office_event.dart';
part 'profile_office_state.dart';

class ProfileOfficeBloc extends Bloc<ProfileOfficeEvent, ProfileOfficeState> {
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
    on<ProfileOfficeEvent>((event, emit) {
      // TODO: implement event handler
    });
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
      final descriptionn = profile.description;
      emit(DisplayOfficeInfoState(
          name: name, email: email, phone: phone, description: descriptionn));
    } catch (e) {
      print("in catch");
      print(e.toString());
      emit(ProfileOfficeErrorState(
          msg: "حدث خطأ عند تحميل بياناتك يرجى المحاولة لاحقاً"));
    }
  }
}
