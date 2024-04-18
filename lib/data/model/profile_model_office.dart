class ProfileOfficeModel {
  final String name;
  final String email;
  final String description;
  // final String address;
  final String image;
  final int phone;

  ProfileOfficeModel(
      {required this.name,
      required this.email,
      required this.description,
      // required this.address,
      required this.phone,
      required this.image});

  factory ProfileOfficeModel.fromJson(Map<String, dynamic> json) {
    return ProfileOfficeModel(
        name: json['name'] ?? "hi",
        email: json['email'] ?? "em",
        description: json['disc'],
        phone: json['phoneNumber'] ?? 7,
        image: json['image'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'disc': description,
      'phoneNumber': phone,
      'image': image
    };
  }
}
