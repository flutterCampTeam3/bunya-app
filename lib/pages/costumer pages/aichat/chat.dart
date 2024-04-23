import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/chat_bloc.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<ChatBloc>();
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(100.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5), // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: const Offset(0, 3), // Offset position
                      ),
                    ],
                  ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackButton(),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                         Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: whiteColor,
                              border: Border.all(color: whiteColor),
                              image: DecorationImage(
                                  image: AssetImage("assets/images/ai.png"),
                                  fit: BoxFit.cover)),
                        ),
                            // CircleAvatar(
                            //   backgroundImage:
                            //       AssetImage('assets/images/ai.png'),
                                  
                            // ),
                            gapWe5,
                            Text(
                              "اسأل بنية",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              body: BlocConsumer<ChatBloc, ChatState>(
                listener: (context, state) {
                  if (state is ErrorState) {
                    context.showErrorSnackBar(context, " هناك خطاء ");
                  }
                },
                builder: (context, state) {
                  return DashChat(
                    inputOptions: InputOptions(
                        // sendButtonBuilder: (send) {
                        //   return Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Icon(
                        //         Icons.send,
                        //         color: brown,
                        //       )
                        //       );
                        // },
                        sendOnEnter: true,
                        alwaysShowSend: true,
                        textController: TextEditingController(),
                        inputTextStyle: const TextStyle(),
                        cursorStyle: CursorStyle(color: brown),
                        inputTextDirection: TextDirection.rtl,
                        inputToolbarPadding: const EdgeInsets.all(20),
                        inputToolbarStyle:
                            const BoxDecoration(color: Colors.white),
                        inputDecoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: darkBrown),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0)),
                          ),
                          hintTextDirection: TextDirection.rtl,
                          hintText: " اكتب هنا",
                          alignLabelWithHint: true,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                          ),
                        )),
                    typingUsers: bloc.typingList,
                    messageOptions: MessageOptions(
                      currentUserContainerColor: Colors.grey,
                      containerColor: Colors.white,
                      showCurrentUserAvatar: true,
                      avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.asset(
                            p0.profileImage ?? 'assets/images/profil.png',
                            height: 50,
                            width: 50,
                          ),
                        );
                      },
                      currentUserTextColor: Colors.black,
                      textColor: Colors.black,
                      messageDecorationBuilder:
                          (message, previousMessage, nextMessage) {
                        if (message.user == bloc.user) {
                          return BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(1),
                                bottomRight: Radius.circular(12),
                              ),
                              color: darkGreyColor);
                        } else {
                          return BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(1),
                              ),
                              color: white);
                        }
                      },
                      showTime: true,
                    ),
                    currentUser: bloc.user,
                    onSend: (ChatMessage chatMessage) async {
                      bloc.add(SendMassageEvent(chatMessage: chatMessage));
                    },
                    messages: bloc.userMasseges,
                  );
                },
              ),
            ));
      }),
    );
  }

  List<Widget> AppBarWidget(BuildContext context) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 20, top: 10),
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              color: const Color(0xffF8F8F6),
              borderRadius: BorderRadius.circular(14)),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              color: Color(0xff9B9B9B),
            ),
            onPressed: () {
              // Your action for back navigation
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
        ),
      ),
    ];
  }
}
