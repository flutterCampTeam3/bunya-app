import 'package:bunya_app/data/model/room_model.dart';
import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/pages/costumer%20pages/chat_page/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class MessageBar extends StatelessWidget {
  MessageBar({super.key, required this.room});
  Room room;

  TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatBloc>(); //-----------
    return Container(
      color: transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: msgController,
                maxLines: null,
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  hintText: 'اكتب هنا',
                  contentPadding: const EdgeInsets.all(8),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (msgController.text.isNotEmpty) {
                  bloc.add(SubmitMessageEvent(msgController.text, room));
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: brownColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
