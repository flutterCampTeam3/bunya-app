part of 'profile_office_bloc.dart';

@immutable
sealed class ProfileOfficeState {}

final class ProfileOfficeInitial extends ProfileOfficeState {}

// final class ActivatedEditModeState extends ProfileOfficeState {
//   String name;
//   String email;

//   ActivatedEditModeState({
//     required this.email,
//     required this.name,
//   });
// }

final class ProfilOfficeSuccessState extends ProfileOfficeState {
  String msg;
  ProfilOfficeSuccessState({required this.msg});
}

class profilePostsSuccesState extends ProfileOfficeState {
  // final List<postModel> classPostId;
  // profilePostsSuccesState ({required this.classPostId});
}
final class LoadingState extends ProfileOfficeState {}


final class DisplayOfficeInfoState extends ProfileOfficeState {
  String name;
  String email;
  String description;
    String image;
  int phone;
  DisplayOfficeInfoState(
      {required this.email,
      required this.name,
      required this.phone,
      required this.description,required this.image});
}

final class ProfileLoadingState extends ProfileOfficeState {}

final class ProfileOfficeErrorState extends ProfileOfficeState {
  final String msg;

  ProfileOfficeErrorState({required this.msg});
}

final class SignedOutState extends ProfileOfficeState {
  final String msg;

  SignedOutState({required this.msg});
}
