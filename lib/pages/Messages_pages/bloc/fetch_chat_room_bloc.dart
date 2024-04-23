import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/chat_profile_model.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'fetch_chat_room_event.dart';
part 'fetch_chat_room_state.dart';

class FetchChatRoomBloc extends Bloc<FetchChatRoomEvent, FetchChatRoomState> {
  final serviceLocator = GetIt.I.get<DBService>();

  FetchChatRoomBloc() : super(FetchChatRoomInitial()) {
    on<FetchRoomsEvent>(fetchRooms);
  }

  FutureOr<void> fetchRooms(FetchRoomsEvent event, emit) async {
    try {
      emit(FetchChatRoomLoadingState());
      final roomsList = await serviceLocator.fetchRooms();
      final roomsWithPerson = await serviceLocator.fetchPersonRoom(roomsList);
      emit(FetchChatRoomSucessState(roomsWithPerson));
    } catch (error) {
      print(error);
      emit(FetchChatRoomErrorState(error.toString()));
    }
  }
}
