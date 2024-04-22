import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
    
  }
 Future pickedPost() async {
    var posts = await ImagePicker().pickImage(source: ImageSource.gallery);

    return (posts!.path);
  }

}
