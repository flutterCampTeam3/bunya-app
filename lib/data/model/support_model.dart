class SupportModel {
 
  final DateTime createdAt;
  final String massage;

  final String email;
  

  SupportModel({
   
    required this.createdAt,
    required this.massage,
   
    required this.email,
    
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) {
    return SupportModel(
       
        createdAt: DateTime.parse(json['created_at']),
        massage: json['massage'] ?? "",
       
        email: json['email'] ?? '',
        );
  }

  Map<String, dynamic> toJson() {
    return {
      
      'created_at': createdAt.toIso8601String(),
      'massage': massage,
      
      'email': email,
     
    };
  }
}
