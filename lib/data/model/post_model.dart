class postModel {
  final String postId;
  final DateTime createdAt;
  final String image;
  final String ofiiceId;
  final String desc;
  final String comment;

  postModel({
    required this.postId,
    required this.createdAt,
    required this.image,
    required this.ofiiceId,
    required this.desc,
    required this.comment,
  });

  factory postModel.fromJson(Map<String, dynamic> json) {
    return postModel(
        postId: json['postId'],
        createdAt: DateTime.parse(json['created_at']),
        image: json['image'] ?? "",
       
       
        ofiiceId: json['ofiiceId'],
        desc: json['desc'] ?? '',
        comment: json['comment'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'created_at': createdAt.toIso8601String(),
      'image': image,
      
    
      'ofiiceId': ofiiceId,
      'desc': desc,
      'comment': comment,
    };
  }
}
