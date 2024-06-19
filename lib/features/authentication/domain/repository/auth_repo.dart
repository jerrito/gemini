import "package:dartz/dartz.dart";
import "package:gemini/features/authentication/data/models/authorization_model.dart";
import "package:gemini/features/authentication/domain/entities/authorization.dart";
import "package:gemini/features/authentication/domain/entities/user.dart";

abstract class AuthenticationRepository {
// signup
  Future<Either<String, SignupResponse>> signup(Map<String, dynamic> params);

// signin
  Future<Either<String, SigninResponse>> signin(Map<String, dynamic> params);


//get user from token
  Future<Either<String, User>> getUserFromToken(Map<String, dynamic> params);

  //cache user
  Future<Either<String, dynamic>> cacheUserData(Map<String, dynamic> params);

  //get User 
  Future<Either<String, User>> getUser(Map<String, dynamic> params);

  //cache token
  Future<Either<String, void>> cacheToken(AuthorizationModel authorization);

  //get token
  Future<Either<String, Authorization>> getToken();
 
  // get cached User 
  Future<Either<String, Map<String, dynamic>>> getCachedUser();

  //log out
   Future<Either<String,String>> logout(Map<String, dynamic> params);

  // refresh toen
  Future<Either<String,String>> refreshToken(Map<String, dynamic> params);
}
