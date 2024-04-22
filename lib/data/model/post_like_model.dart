class postLikeModel {
  final String postId;
  final DateTime createdAt;
  final String customerId;
  final String postOfficeId;

  postLikeModel({
    required this.postId,
    required this.createdAt,
    required this.customerId,
    required this.postOfficeId,
  });

  factory postLikeModel.fromJson(Map<String, dynamic> json) {
    return postLikeModel(
      postId: json['postId'],
      createdAt: DateTime.parse(json['created_at']),
      customerId: json['customerId'],
      postOfficeId: json['postOfficeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'created_at': createdAt.toIso8601String(),
      'customerId': customerId,
      'postOfficeId': postOfficeId,
    };
  }
}
