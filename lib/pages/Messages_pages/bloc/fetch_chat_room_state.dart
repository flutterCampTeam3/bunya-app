part of 'fetch_chat_room_bloc.dart';


sealed class FetchChatRoomState {}

final class FetchChatRoomInitial extends FetchChatRoomState {}

final class FetchChatRoomLoadingState extends FetchChatRoomState {}

final class FetchChatRoomSucessState extends FetchChatRoomState {
  List<ChatProfileModel> chatProfileList;
  FetchChatRoomSucessState(this.chatProfileList);
}

final class FetchChatRoomErrorState extends FetchChatRoomState {
  String msg;
  FetchChatRoomErrorState(this.msg);
}
