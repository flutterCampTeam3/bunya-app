class ProfileModel {
  final String name;
  final String email;
  final String image;
  final int phone;

  ProfileModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.image});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        name: json['name'] ?? "hi",
        email: json['email'] ?? "em",
        phone: json['phoneNumber'] ?? 7,
        image: json['image'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phoneNumber': phone, 'image': image};
  }
}
