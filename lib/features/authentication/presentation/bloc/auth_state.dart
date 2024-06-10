part of 'auth_bloc.dart';

abstract class AuthenticationState {}

class InitState extends AuthenticationState {}

class SignupLoaded extends AuthenticationState {
  final User user;

  SignupLoaded({required this.user});
}

class SignupLoading extends AuthenticationState {}

class SignupError extends AuthenticationState {
  final String errorMessage;
  SignupError({required this.errorMessage});
}

class SigninLoaded extends AuthenticationState {
  final Data data;

  SigninLoaded({required this.data});
}

class SigninLoading extends AuthenticationState {}

class SigninError extends AuthenticationState {
  final String errorMessage;
  SigninError({required this.errorMessage});
}

class GetUserFromTokenLoaded extends AuthenticationState {
  final User user;
  GetUserFromTokenLoaded({required this.user});
}

class GetUserFromTokenLoading extends AuthenticationState {}

class GetUserFromTokenError extends AuthenticationState {
  final String errorMessage;
  GetUserFromTokenError({required this.errorMessage});
}

class CacheUserDataLoaded extends AuthenticationState {
  CacheUserDataLoaded();
}

class CacheUserDataLoading extends AuthenticationState {}

class CacheUserDataError extends AuthenticationState {
  final String errorMessage;
  CacheUserDataError({required this.errorMessage});
}

class GetUserCachedDataLoaded extends AuthenticationState {
  final User user;
  GetUserCachedDataLoaded({required this.user});
}

class GetUserDataLoading extends AuthenticationState {}

class GetUserCacheDataError extends AuthenticationState {
  final String errorMessage;
  GetUserCacheDataError({required this.errorMessage});
}

class CacheTokenLoaded extends AuthenticationState {
  final String token;
  CacheTokenLoaded({required this.token});
}

class CacheTokenError extends AuthenticationState {
  final String errorMessage;

  CacheTokenError({required this.errorMessage});
}

class GetTokenLoaded extends AuthenticationState {
  final String token;
  GetTokenLoaded({required this.token});
}

class GetTokenError extends AuthenticationState {
  final String errorMessage;
  GetTokenError({required this.errorMessage});
}

class GetUserLoaded extends AuthenticationState {
  final User user;

  GetUserLoaded({required this.user});
}

class GetUserLoading extends AuthenticationState {}

class GetUserError extends AuthenticationState {
  final String errorMessage;
  GetUserError({required this.errorMessage});
}