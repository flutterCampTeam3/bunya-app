part of 'fetch_chat_room_bloc.dart';

@immutable
sealed class FetchChatRoomEvent {}

class FetchRoomsEvent extends FetchChatRoomEvent {}
