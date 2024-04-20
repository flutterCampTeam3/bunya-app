class postLikeModel {
  final String postId;
  final DateTime createdAt;
  final String customerId;

  postLikeModel({
    required this.postId,
    required this.createdAt,
    required this.customerId,
  });

  factory postLikeModel.fromJson(Map<String, dynamic> json) {
    return postLikeModel(
      postId: json['postId'],
      createdAt: DateTime.parse(json['created_at']),
      customerId: json['customerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'created_at': createdAt.toIso8601String(),
      'customerId': customerId,
    };
  }
}
