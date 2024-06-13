part of 'auth_bloc.dart';

sealed class AuthenticationEvent {}

class SignupEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;
  SignupEvent({required this.params});
}

class SigninEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;
  SigninEvent({required this.params});
}

class GetUserFromTokenEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;
  GetUserFromTokenEvent({required this.params});
}

class CreateUserWithEmailAndPasswordEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;
  CreateUserWithEmailAndPasswordEvent({required this.params});
}

class CacheUserDataEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  CacheUserDataEvent({required this.params});
}

class GetUserCacheDataEvent extends AuthenticationEvent {
  GetUserCacheDataEvent();
}

class CacheTokenEvent extends AuthenticationEvent {
  final String token;
  CacheTokenEvent({required this.token});
}

class GetTokenEvent extends AuthenticationEvent {
  GetTokenEvent();
}

class GetUserEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  GetUserEvent({required this.params});
}
