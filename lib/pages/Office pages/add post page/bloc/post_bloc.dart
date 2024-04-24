import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/post_model.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    File PostImageFile;

    on<ChoseImagePostEvent>((event, emit) async {
      File avatar = File(await pickedPost());
      GetIt.I.get<DBService>().PostImageFile = avatar;
      emit(ShowImagepostState(avatar));
    });
    //---------  new event to test sent post

    on<UploadPost>((event, emit) async {
      // GetIt.I.get<DBService>().deleteImage(event.bucketName, event.fileName);
      GetIt.I.get<DBService>().uploadImage(
          GetIt.I.get<DBService>().PostImageFile,
          event.bucketName,
          event.fileName);

      GetIt.I.get<DBService>().imageId =
          await GetIt.I.get<DBService>().UrlImage(event.fileName);
    });

    on<UploadDesc>((event, emit) async {
      await GetIt.I.get<DBService>().addPost(desc: event.desc);
      emit(successState());
    });
  }

  Future pickedPost() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);

    return (img!.path);
  }
}
/*
https://mtaainvajktwbwpffkxw.supabase.co/storage/v1/object/public/profile/PostFolder/c8a07680-859e-455b-8ce0-9ffedb45de1a%20%20%20%20%20//.%20
https://mtaainvajktwbwpffkxw.supabase.co/storage/v1/object/public/profile/c8a07680-859e-455b-8ce0-9ffedb45de1a
https://mtaainvajktwbwpffkxw.supabase.co/storage/v1/object/public/profile/c8a07680-859e-455b-8ce0-9ffedb45de1a
https://mtaainvajktwbwpffkxw.supabase.co/storage/v1/object/public/profile/PostFolder/c8a07680-859e-455b-8ce0-9ffedb45de1a
*/