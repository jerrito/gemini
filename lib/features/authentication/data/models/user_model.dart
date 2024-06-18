import 'package:gemini/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.userName,
    required super.email,
    required super.password,
    required super.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) => UserModel(
        userName: json?["userName"],
        email: json?["email"],
        password: json?["password"],
        profile: json?["profile"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "user_name": userName,
        "email": email,
        "password": password,
        "profile": profile,
      };
}

class DataModel extends Data {
  const DataModel({required super.user, required super.token});

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      DataModel(user: UserModel.fromJson(json["user"]), token: json["token"]);
}
