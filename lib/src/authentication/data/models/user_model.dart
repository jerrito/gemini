import 'package:gemini/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.userName,
    required super.email,
    required super.password,
    required super.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) => UserModel(
        userName: json?["userName"],
        email: json?["email"],
        password: json?["password"],
        phoneNumber: json?["phoneNumber"],
      );

      Map<String, dynamic> toMap()=>
      {
        "user_name":userName,
        "email":email,
        "password":password,
        "phone_number":phoneNumber,
      };
}
