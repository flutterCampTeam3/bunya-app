class Message {
  String id;
  String profileId;
  String content;
  DateTime createdAt;

  Message(
    this.id,
    this.profileId,
    this.content,
    this.createdAt,
  );

  Message.fromJson({
    required Map<String, dynamic> json,
  })  : id = json['id'],
        profileId = json['profile_id'],
        content = json['content'],
        createdAt = DateTime.parse(json['created_at']);
}
