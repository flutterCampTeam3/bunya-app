class Room {
  int id;
  String customer_id;
  String offecer_id;
  DateTime createdAt;
  // bool isMine;

  Room(
    this.id,
    this.customer_id,
    this.offecer_id,
    this.createdAt,
    // this.isMine,
  );

  Room.fromJson({
    required Map<String, dynamic> json,
  })  : id = json['id'],
        customer_id = json['customer_id'],
        offecer_id = json['offecer_id'],
        createdAt = DateTime.parse(json['created_at']);
  // isMine = myUserID == json['profile_id'
}
