import "package:dartz/dartz.dart";
import "package:gemini/src/authentication/domain/entities/user.dart";


abstract class UserRepository{

// signup
Future<Either<String,User>> signup(Map<String, dynamic> params);

// signin
Future<Either<String,User>> signin(Map<String, dynamic> params);


// verify token
Future<Either<String,dynamic>> verifyToken(Map<String, dynamic> params);

//get OTP
Future<Either<String,dynamic>> getOTP(Map<String, dynamic> params);

//get user from token
Future<Either<String, dynamic>> getUserFromToken(Map<String, dynamic> params);


//confrm token
 Future<Either<String, bool>> confirmToken(Map<String, dynamic> params); 
}
