class OfficesModel {
  final String officeId;
  final DateTime createdAt;
  final String name;
  final String departmentId;
  final String disc;
  final int cn;
  final String image;
  final int phoneNumber;
  final String email;

  OfficesModel({
    required this.officeId,
    required this.createdAt,
    required this.name,
    required this.departmentId,
    required this.disc,
    required this.cn,
    required this.image,
    required this.phoneNumber,
    required this.email,
  });

  factory OfficesModel.fromJson(Map<String, dynamic> json) {
    return OfficesModel(
      officeId: json['officeId'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'] ?? "",
      departmentId: json['departmentId'] ?? "",
      disc: json['disc'],
      cn: json['cn'] ?? 0,
      image: json['image'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
      email: json['email'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'officeId': officeId,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'departmentId': departmentId,
      'disc': disc,
      'cn': cn,
      'image': image,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }
}
