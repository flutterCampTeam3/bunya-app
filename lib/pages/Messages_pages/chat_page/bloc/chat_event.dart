part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class GetMessagesEvent extends ChatEvent {
  Room room;
  GetMessagesEvent(this.room);
}

// Submit message Event
// ignore: must_be_immutable
class SubmitMessageEvent extends ChatEvent {
  String message;
  Room room;
  SubmitMessageEvent(this.message, this.room);
}
