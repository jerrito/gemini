import 'package:equatable/equatable.dart';
import 'package:gemini/features/authentication/domain/entities/authorization.dart';
import 'package:gemini/features/authentication/domain/usecases/refresh_token.dart';

class User extends Equatable {
  final String? userName, email, password, profile;

  const User({
    required this.userName,
    required this.email,
    required this.password,
    required this.profile,
  });

  @override
  List<Object?> get props => [
        userName,
        email,
        password,
        profile,
      ];
  Map<String, dynamic> toMap() => {
        "userName": userName,
        "email": email,
        "password": password,
        "profile": profile,
      };
}



class SigninResponse extends Equatable {
  final User user;
  final Authorization authorization;

 const SigninResponse({required this.user, required this.authorization});
 
  @override
  List<Object?> get props => [user, authorization];
}

class SignupResponse extends Equatable {

  final User user;
  final RefreshToken refreshToken;

  const SignupResponse({required this.user, required this.refreshToken});

  

  @override
  List<Object?> get props => throw UnimplementedError();

}

