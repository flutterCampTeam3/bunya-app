import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:bunya_app/pages/Messages_pages/bloc/fetch_chat_room_bloc.dart';
import 'package:bunya_app/pages/Messages_pages/widgets/message_list.dart';
import 'package:bunya_app/pages/costumer%20pages/chat_page/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageListPage extends StatelessWidget {
  const MessageListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) => FetchChatRoomBloc()..add(FetchRoomsEvent()),
        child: Builder(builder: (context) {
          return Scaffold(
            // backgroundColor: white,
            body: Stack(
              children: [
                // Background Image
                /*
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/introv4.png', // Your image path
                          // fit: BoxFit.cover,
                        ),
                      ),
                      */
                SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        //const AppBarWidget(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              gapH20,
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    " الرسائل",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              gapH10,
                              BlocConsumer<FetchChatRoomBloc,
                                  FetchChatRoomState>(
                                listener: (context, state) {
                                  if (state is FetchChatRoomErrorState) {
                                    context.showErrorSnackBar(
                                        context, state.msg);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is FetchChatRoomLoadingState) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (state
                                      is FetchChatRoomSucessState) {
                                    return SizedBox(
                                        height: 800,
                                        child: ListView.builder(
                                          itemCount:
                                              state.chatProfileList.length,
                                          itemBuilder: (context, index) {
                                            final messageWidget =
                                                state.chatProfileList[index];
                                            return MessageListWidget(
                                                path: messageWidget.image,
                                                title: messageWidget.name,
                                                sendTime: "",
                                                onTap: () {
                                                  context.pushTo(
                                                      view: ChatView(
                                                          room: messageWidget
                                                              .room!));
                                                });
                                          },
                                        ));
                                  } else {
                                    return const Center(
                                      child: Text("Error"),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
