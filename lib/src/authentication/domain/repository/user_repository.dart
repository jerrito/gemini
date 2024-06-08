import "package:dartz/dartz.dart";
import "package:gemini/src/authentication/domain/entities/user.dart";

abstract class UserRepository {
// signup
  Future<Either<String, User>> signup(Map<String, dynamic> params);

// signin
  Future<Either<String, Data>> signin(Map<String, dynamic> params);


//get user from token
  Future<Either<String, User>> getUserFromToken(Map<String, dynamic> params);

  //cache user
  Future<Either<String, dynamic>> cacheUserData(Map<String, dynamic> params);

  //get User Data
  Future<Either<String, User>> getUser(Map<String, dynamic> params);

  //cache token
  Future<Either<String, void>> cacheToken(String token);

  //get token
  Future<Either<String, String>> getToken();
}
