//-------------------------office User Model
class OfficeUserModel {
  late final String id;
  late final String createdAt;
  late final String name;
  late final String departmentId;
  late final String phoneNumber;

  OfficeUserModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.departmentId,
    required this.phoneNumber,
  });

  OfficeUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    name = json['name'];
    departmentId = json['departmentId'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['name'] = name;
    data['departmentId'] = departmentId;
    data['phoneNumber'] = phoneNumber;

    return data;
  }
}
