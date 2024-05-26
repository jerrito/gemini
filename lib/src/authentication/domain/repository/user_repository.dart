import "package:dartz/dartz.dart";
import "package:firebase_auth/firebase_auth.dart" as auth;
import "package:gemini/src/authentication/domain/entities/user.dart";

abstract class UserRepository {
// signup
  Future<Either<String, User>> signup(Map<String, dynamic> params);

// signin
  Future<Either<String, User>> signin(Map<String, dynamic> params);

// verify token
  Future<Either<String, dynamic>> verifyToken(Map<String, dynamic> params);

//get OTP
  Future<Either<String, dynamic>> getOTP(Map<String, dynamic> params);

//get user from token
  Future<Either<String, User>> getUserFromToken(Map<String, dynamic> params);

//confrm token
  Future<Either<String, bool>> confirmToken(Map<String, dynamic> params);

  // signup supabase
  Future<Either<String, auth.UserCredential>> createUserWithEmailAndPassword(
      Map<String, dynamic> params);

  //signin otp
  Future<Either<String, auth.UserCredential>> signinWithEmailPassword(
      Map<String, dynamic> params);

  // signin with password
  Future<Either<String, void>> signInWithEmailLink(Map<String, dynamic> params);

  //add user
  Future<Either<String, bool>> isSignInWithEmailLink(
      Map<String, dynamic> params);

  //cache user
  Future<Either<String, dynamic>> cacheUserData( User userData);

  //get User Data
  Future<Either<String, User>> getUserData();

  //cache token 
  Future<Either<String, void>> cacheToken(String token);

  //get token
  Future<Either<String,String>> getToken();
}
