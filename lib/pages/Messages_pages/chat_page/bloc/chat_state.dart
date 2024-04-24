part of 'chat_bloc.dart';

@immutable
sealed class chatState {}

final class ChatInitial extends chatState {}

// ---- ResultStates ----
class SuccessState extends chatState {}

// ignore: must_be_immutable
class ErrorState extends chatState {
  String msg;
  ErrorState(this.msg);
}

// ---- Show Messages State ---
// ignore: must_be_immutable
class ShowMessageStreamState extends chatState {
  Stream<List<Message>> messageList;
  ShowMessageStreamState(
    this.messageList,
  );
}

// ---- Sending message state -----
class SendMessageState extends chatState {}
