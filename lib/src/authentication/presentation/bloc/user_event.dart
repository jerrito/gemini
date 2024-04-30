part of 'user_bloc.dart';

abstract class UserEvent {}

class SignupEvent extends UserEvent {
  final Map<String, dynamic> params;
  SignupEvent({required this.params});
}

class SigninEvent extends UserEvent {
  final Map<String, dynamic> params;
  SigninEvent({required this.params});
}

class VerifyOTPEvent extends UserEvent {
  final Map<String, dynamic> params;
  VerifyOTPEvent({required this.params});
}

class ConfirmTokenEvent extends UserEvent {
  final Map<String, dynamic> params;
  ConfirmTokenEvent({required this.params});
}

class GetUserFromTokenEvent extends UserEvent {
  final Map<String, dynamic> params;
  GetUserFromTokenEvent({required this.params});
}

class GetOTPEvent extends UserEvent {
  final Map<String, dynamic> params;
  GetOTPEvent({required this.params});
}

class SignupSupabaseEvent extends UserEvent {
  final Map<String, dynamic> params;
  SignupSupabaseEvent({required this.params});
}

class SigninPasswordSupabaseEvent extends UserEvent {
  final Map<String, dynamic> params;
  SigninPasswordSupabaseEvent({required this.params});
}

class SigninOTPSupabaseEvent extends UserEvent {
  final Map<String, dynamic> params;
  SigninOTPSupabaseEvent({required this.params});
}

class AddUserSupabaseEvent extends UserEvent {
  final Map<String, dynamic> params;
  AddUserSupabaseEvent({required this.params});
}

class CacheUserDataEvent extends UserEvent {
  final supabase.User user;
  final String userName;
  CacheUserDataEvent({required this.user, required this.userName});
}

class GetUserCacheDataEvent extends UserEvent {
  GetUserCacheDataEvent();
}
