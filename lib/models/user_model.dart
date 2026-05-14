class UserModel {
  final int id;
  final String fname;
  final String lname;
  final String username;
  final String email;
  final String avatar;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.fname,
    required this.lname,
    required this.username,
    required this.email,
    required this.avatar,
    required this.createdAt,
  });

  String get fullName => "$fname $lName";

  String get lName => lname;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] as int,
      fname: json["fname"] as String,
      lname: json["lname"] as String,
      username: json["username"] as String,
      email: json["email"] as String,
      avatar: json["avatar"] as String,
      createdAt: DateTime.parse(json["createdAt"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fname": fname,
      "lname": lname,
      "username": username,
      "email": email,
      "avatar": avatar,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
