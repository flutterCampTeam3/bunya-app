import 'package:bunya_app/data/model/messege_model.dart';
import 'package:bunya_app/data/service/supabase%20services/services.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// import 'package:public_chat_app/constants/spacing.dart';
// import 'package:public_chat_app/features/chat/model/message_model.dart';
// import 'package:public_chat_app/features/auth/model/profile_model.dart';
// import 'package:timeago/timeago.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    bool isMine =
        message.profileId == GetIt.I.get<DBService>().getCurrentUser();

    List<Widget> chatContents = [
      // Show a Circular avatar for senders
      // if (!message.isMine)

      // kH8,
      // kH4,
      Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color:
                isMine ? darkBrown : const Color.fromARGB(255, 223, 223, 223),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              bottomLeft:
                  isMine ? const Radius.circular(15) : const Radius.circular(0),
              bottomRight:
                  isMine ? const Radius.circular(0) : const Radius.circular(15),
              topRight: const Radius.circular(15),
            ),
          ),
          child: Text(
            message.content,
            style: TextStyle(
              color: isMine ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      // kH8,
      // kH4,
      // Text(format(message.createdAt, locale: 'en_short')),
      // kV64,
    ];
    if (isMine) {
      chatContents = chatContents.reversed.toList();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: chatContents,
      ),
    );
  }
}
