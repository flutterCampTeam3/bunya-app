import 'package:bunya_app/data/model/room_model.dart';

class ChatProfileModel {
  final String name;
  final String image;
  final Room? room;

  ChatProfileModel({
    required this.name,
    required this.image,
    this.room,
  });

  factory ChatProfileModel.fromJson(Map<String, dynamic> json, Room room) {
    return ChatProfileModel(
        name: json['name'], image: json['image'], room: room);
  }
}
