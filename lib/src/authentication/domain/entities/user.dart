import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? userName, email, password, phoneNumber;

  const User({
    required this.userName,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        userName,
        email,
        password,
        phoneNumber,
      ];
  Map<String, dynamic> toMap() => {
        "userName": userName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
      };
}

class Data extends Equatable {
  final User user;
  final String token;

 const Data({required this.user, required this.token});
 
  @override
  List<Object?> get props => [user, token];
}
