import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import 'package:meta/meta.dart';

import '../../../../data/service/gpt_api.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatUser user = ChatUser(
      id: "1");
  ChatUser bot = ChatUser(id: "2", profileImage: "assets/images/ai.png");

  List<ChatMessage> userMasseges = [];

  List<ChatUser> typingList = [];

  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
    on<SendMassageEvent>(sendMassage);
  }

  FutureOr<void> sendMassage(
      SendMassageEvent event, Emitter<ChatState> emit) async {
    try {
      userMasseges.insert(0, event.chatMessage);
      typingList.add(bot);
      emit(SuccessState());
      final answer = await GPT().getChatAnswer(event.chatMessage.text);
print("object");
      final newMassage = ChatMessage(
        text: answer,
        user: bot,
        createdAt: DateTime.now(),
      );
      userMasseges.insert(0, newMassage);
      typingList.remove(bot);
      emit(SuccessState());
    } catch (error) {
      emit(ErrorState(massage: error.toString()));
    }
  }
}
