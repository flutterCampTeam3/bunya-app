import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/post_model.dart';
import 'package:bunya_app/data/service/supabase%20services/services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<ChoseImagePostEvent>((event, emit) async {
      File avatar = File(await pickedPost());
      GetIt.I.get<DBService>().PostImageFile = avatar;
      emit(ShowImagepostState(avatar));
    });
     
    on<UploadPost>((event, emit) async {
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
