import "package:dartz/dartz.dart";
import "package:gemini/src/authentication/domain/entities/user.dart";


abstract class UserRepository{
Future<Either<String,User>> signup(Map<String, dynamic> params);
Future<Either<String,User>> signin(Map<String, dynamic> params);
Future<Either<String,dynamic>> verifyToken(Map<String, dynamic> params);
}
