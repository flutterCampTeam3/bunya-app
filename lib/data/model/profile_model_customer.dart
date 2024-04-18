class ProfileModel {
  final String name;
  final String email;
  final int phone;

  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? "hi",
      email: json['email'] ?? "em",
      phone: json['phoneNumber'] ?? 7,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phone,
    };
  }
}
