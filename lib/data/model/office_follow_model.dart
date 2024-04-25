class ProfileOfficeFollowModel {
  final String officeId;
  final String customerId;

  ProfileOfficeFollowModel({
    required this.officeId,
    required this.customerId,
  });

  factory ProfileOfficeFollowModel.fromJson(Map<String, dynamic> json) {
    return ProfileOfficeFollowModel(
      officeId: json['officeId'] ?? " ",
      customerId: json['customerId'] ?? " ",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'officeId': officeId,
      'customerId': customerId,
    };
  }
}
