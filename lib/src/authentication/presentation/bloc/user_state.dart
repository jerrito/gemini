
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

class SignupSupabaseLoaded extends UserState{
  final supabase.AuthResponse data;
 SignupSupabaseLoaded({required this.data});  
}

class SignupSupabaseLoading extends UserState{}

class SignupSupabaseError extends UserState{
  final String errorMessage;
 SignupSupabaseError({required this.errorMessage});
}


class SigninOTPSupabaseLoaded extends UserState{
//  final void data;
 SigninOTPSupabaseLoaded();  
}

class SigninOTPSupabaseLoading extends UserState{}

class SigninOTPSupabaseError extends UserState{
  final String errorMessage;
 SigninOTPSupabaseError({required this.errorMessage});
}


class SigninPasswordSupabaseLoaded extends UserState{
  final dynamic data;
 SigninPasswordSupabaseLoaded({required this.data});  
}

class SigninPasswordSupabaseLoading extends UserState{}

class SigninPasswordSupabaseError extends UserState{
  final String errorMessage;
 SigninPasswordSupabaseError({required this.errorMessage});
}

class AddUserSupabaseLoaded extends UserState{
  final dynamic data;
 AddUserSupabaseLoaded({required this.data});  
}

class AddUserSupabaseLoading extends UserState{}

class AddUserSupabaseError extends UserState{
  final String errorMessage;
 AddUserSupabaseError({required this.errorMessage});
}

class CacheUserDataLoaded extends UserState{
  final dynamic data;
 CacheUserDataLoaded({required this.data});  
}

class CacheUserDataLoading extends UserState{}

class CacheUserDataError extends UserState{
  final String errorMessage;
 CacheUserDataError({required this.errorMessage});
}


class GetUserDataLoaded extends UserState{
  final dynamic data;
 GetUserDataLoaded({required this.data});  
}

class GetUserDataLoading extends UserState{}

class GetUserDataError extends UserState{
  final String errorMessage;
 GetUserDataError({required this.errorMessage});
}