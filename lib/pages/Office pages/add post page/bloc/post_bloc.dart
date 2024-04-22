import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<ChoseImagePostEvent>((event, emit) async{
     File post =await pickedPost();
     emit(ShowImagepostState(post));
    });

      on<UploadPost>((event, emit) async{
     
     //---- make it in other event in the bittin to push
   
    });
  }

 Future pickedPost() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);

    return (img!.path);
  }

}
