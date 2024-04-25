import 'package:bunya_app/data/model/messege_model.dart';
import 'package:bunya_app/data/model/room_model.dart';
import 'package:bunya_app/pages/costumer%20pages/chat_page/bloc/chat_bloc.dart';
import 'package:bunya_app/pages/costumer%20pages/chat_page/widgets/chat_bubble.dart';
import 'package:bunya_app/pages/costumer%20pages/chat_page/widgets/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.room});
  final Room room;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: Builder(builder: (context) {
        final chatBloc = context.read<ChatBloc>();
        chatBloc.add(GetMessagesEvent(room));
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded))
            ],
            // backgroundColor: const Color.fromARGB(255, 54, 54, 54),
            // title: const Text(
            //   "Chat Room",
            //   style: TextStyle(color: Colors.white),
            // ),
            // centerTitle: true,
            // leading: BlocListener<AuthBloc, AuthState>(
            //   listener: (context, state) {
            //     if (state is LogOutSuccessState) {
            //       context.pushAndRemove(LoginView());
            //     }
            //     if (state is LogOutErrorState) {
            //       context.showErrorSnackBar(state.msg);
            //     }
            //   },
            //   child: IconButton(
            //     onPressed: () {
            //       authBloc.add(LogoutEvent());
            //     },
            //     icon: const Icon(
            //       Icons.logout_outlined,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ),
          //==============================================================
          body: BlocBuilder<ChatBloc, chatState>(
            builder: (context, state) {
              if (state is ShowMessageStreamState) {
                return StreamBuilder<List<Message>>(
                  stream: state.messageList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final messages = snapshot.data;

                      return Column(
                        children: [
                          Expanded(
                            child: messages!.isEmpty
                                ? const Center(
                                    child: Text("Start Chatting"),
                                  )
                                : ListView.builder(
                                    reverse: true,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      final message = messages[index];
                                      chatBloc.loadProfileCache(
                                          message.profileId, room);
                                      return ChatBubble(
                                        message: message,
                                      );
                                    },
                                  ),
                          ),
                          MessageBar(
                            room: room,
                          ),
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return const Center(
                      child: Text("Sorry Nothing to display"),
                    );
                  },
                );
              }
              return const Center(
                child: Text("Sorry Nothing to display"),
              );
            },
          ),
        );
      }),
    );
  }
}
