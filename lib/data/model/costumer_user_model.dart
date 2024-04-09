//-------------------------costumer User Model
class CostumerUserModel {
  late final String id;
  late final String createdAt;
  late final String name;
  late final String email;
  late final String phoneNumber;

  CostumerUserModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  CostumerUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['name'] = name;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;

    return data;
  }
}
