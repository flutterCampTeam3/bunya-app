part of 'office_office_bloc.dart';

@immutable
sealed class OfficeOfficeEvent {}


class ShowDataIdOfficeEvent extends OfficeOfficeEvent {
  final String id;
  ShowDataIdOfficeEvent({required this.id});
}

class CheckFollowOfficeEvent extends OfficeOfficeEvent {
  final String id;
  CheckFollowOfficeEvent({required this.id});
}

class AddFollowOfficeEvent extends OfficeOfficeEvent {
  final String id;
  AddFollowOfficeEvent({required this.id});
}

class DeleteFollowOfficeEvent extends OfficeOfficeEvent {
  final String id;
  DeleteFollowOfficeEvent({required this.id});
}

class CheckFollowNumberOfficeEvent extends OfficeOfficeEvent {
  final String officeId;
  CheckFollowNumberOfficeEvent({required this.officeId});
}
