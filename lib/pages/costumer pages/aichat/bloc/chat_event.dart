part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class SendMassageEvent extends ChatEvent {
  final ChatMessage chatMessage;

  SendMassageEvent({required this.chatMessage});
}

