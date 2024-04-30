import "package:dartz/dartz.dart";
import "package:gemini/src/authentication/domain/entities/user.dart";
import "package:supabase_flutter/supabase_flutter.dart" as supabase;

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
  Future<Either<String, supabase.AuthResponse>> signUpSupabase(
      Map<String, dynamic> params);

  //signin otp
  Future<Either<String, void>> signInOTPSupabase(Map<String, dynamic> params);

  // signin with password
  Future<Either<String, supabase.AuthResponse>> signInPasswordSupabase(
      Map<String, dynamic> params);

  //add user
  Future addUserSupabase(Map<String, dynamic> params);
 
 //cache user
 Future<Either<String,supabase.User>> cacheUserData(supabase.User user, String userName);

  //get User Data
 Future<Either<String,supabase.User>>  getUserData();
}
