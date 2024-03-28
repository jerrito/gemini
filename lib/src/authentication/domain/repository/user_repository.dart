import "package:dartz/dartz.dart";
import "package:gemini/src/authentication/domain/entities/user.dart";


abstract class UserRepository{

// signup
Future<Either<String,User>> signup(Map<String, dynamic> params);

// signin
Future<Either<String,User>> signin(Map<String, dynamic> params);


// verify token
Future<Either<String,dynamic>> verifyToken(Map<String, dynamic> params);

}
