
part  of 'user_bloc.dart';

abstract class UserState{}

class InitState extends UserState{

}

class SignupLoaded extends UserState{
  final User user;

  SignupLoaded({required this.user});
  
}
class SignupLoading extends UserState{}

class SignupError extends UserState{
  final String errorMessage;
  SignupError({required this.errorMessage});
}



class SigninLoaded extends UserState{
  final User user;

  SigninLoaded({required this.user});
  
}
class SigninLoading extends UserState{}

class SigninError extends UserState{
  final String errorMessage;
  SigninError({required this.errorMessage});
}
class GetUserFromTokenLoaded extends UserState{
  final User user;
 GetUserFromTokenLoaded({required this.user});  
}
class GetUserFromTokenLoading extends UserState{}

class GetUserFromTokenError extends UserState{
  final String errorMessage;
  GetUserFromTokenError({required this.errorMessage});
}

class ConfirmTokenLoaded extends UserState{
  final bool confirm;
 ConfirmTokenLoaded({required this.confirm});  
}

class ConfirmTokenLoading extends UserState{}

class ConfirmTokenError extends UserState{
  final String errorMessage;
  ConfirmTokenError({required this.errorMessage});
}

class GetOTPLoaded extends UserState{
  final User user;
 GetOTPLoaded({required this.user});  
}

class GetOTPLoading extends UserState{}

class GetOTPError extends UserState{
  final String errorMessage;
  GetOTPError({required this.errorMessage});
}

class VerifyOTPLoaded extends UserState{
  final dynamic data;
 VerifyOTPLoaded({required this.data});  
}

class VerifyOTPLoading extends UserState{}

class VerifyOTPError extends UserState{
  final String errorMessage;
  VerifyOTPError({required this.errorMessage});
}
