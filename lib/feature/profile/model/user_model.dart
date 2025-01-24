class UserModel {
  final String email;
  final String phone;
  final String name;
  final String imgUrl;

  UserModel({
    required this.email,
    required this.phone,
    required this.name,
    required this.imgUrl,
  });

  // Convert User object to a Map for database insertion or update
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phone': phone,
      'name': name,
      'img_url': imgUrl,
    };
  }

  // Create a User object from a Map (for database response)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      phone: map['phone'],
      name: map['name'],
      imgUrl: map['img_url'],
    );
  }
}