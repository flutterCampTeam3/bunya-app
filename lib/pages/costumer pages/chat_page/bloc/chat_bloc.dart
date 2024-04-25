// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/messege_model.dart';
import 'package:bunya_app/data/model/profile_model_customer.dart';
import 'package:bunya_app/data/model/room_model.dart';
import 'package:bunya_app/data/service/supabase%20services/services.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, chatState> {
  final serviceLocator = GetIt.I.get<DBService>();
  Map<String, ProfileModel> profileCache = {};

  // Map to store ID as a key and
  //Profile object to store profile data
  Map<String, ProfileModel> customerCache = {};
  // Map<String, Profile> profileCache = {};

  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});

    //--- Get All Messages ----
    on<GetMessagesEvent>(getMessages);

    // -- Submit/Send a Message ---
    on<SubmitMessageEvent>(submitMessage);
  }

  FutureOr<void> submitMessage(SubmitMessageEvent event, emit) async {
    try {
      await serviceLocator.submitMessage(event.message, event.room);
      emit(SendMessageState());
      await serviceLocator.getMessagesStream(event.room.id);
      Stream<List<Message>> messages = serviceLocator.listOfMessages;
      emit(ShowMessageStreamState(messages));
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  FutureOr<void> getMessages(GetMessagesEvent event, emit) async {
    await serviceLocator.getMessagesStream(event.room.id);
    Stream<List<Message>> messages = serviceLocator.listOfMessages;
    emit(ShowMessageStreamState(messages));
  }

  //------ Loading Profile message Data ---
  Future<void> loadProfileCache(String profileId, Room room) async {
    if (profileCache[profileId] != null) {
      return;
    }
    final profileData = await serviceLocator.getProfileData(profileId);
    profileCache[profileId] = profileData;
    await serviceLocator.getMessagesStream(room.id);
    Stream<List<Message>> messages = serviceLocator.listOfMessages;
    // ignore: invalid_use_of_visible_for_testing_member
    emit(ShowMessageStreamState(messages));
  }
}
