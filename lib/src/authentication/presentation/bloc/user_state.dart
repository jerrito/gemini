part of 'user_bloc.dart';

abstract class UserState {}

class InitState extends UserState {}

class SignupLoaded extends UserState {
  final User user;

  SignupLoaded({required this.user});
}

class SignupLoading extends UserState {}

class SignupError extends UserState {
  final String errorMessage;
  SignupError({required this.errorMessage});
}

class SigninLoaded extends UserState {
  final Data data;

  SigninLoaded({required this.data});
}

class SigninLoading extends UserState {}

class SigninError extends UserState {
  final String errorMessage;
  SigninError({required this.errorMessage});
}

class GetUserFromTokenLoaded extends UserState {
  final User user;
  GetUserFromTokenLoaded({required this.user});
}

class GetUserFromTokenLoading extends UserState {}

class GetUserFromTokenError extends UserState {
  final String errorMessage;
  GetUserFromTokenError({required this.errorMessage});
}
class CacheUserDataLoaded extends UserState {
  CacheUserDataLoaded();
}

class CacheUserDataLoading extends UserState {}

class CacheUserDataError extends UserState {
  final String errorMessage;
  CacheUserDataError({required this.errorMessage});
}

class GetUserCachedDataLoaded extends UserState {
  final User user;
  GetUserCachedDataLoaded({required this.user});
}

class GetUserDataLoading extends UserState {}

class GetUserCacheDataError extends UserState {
  final String errorMessage;
  GetUserCacheDataError({required this.errorMessage});
}

class CacheTokenLoaded extends UserState {
  final String token;
  CacheTokenLoaded({required this.token});
}

class CacheTokenError extends UserState {
  final String errorMessage;

  CacheTokenError({required this.errorMessage});

}


class GetTokenLoaded extends UserState {
  final String token;
  GetTokenLoaded({required this.token});
}

class GetTokenError extends UserState {
  final String errorMessage;
  GetTokenError({required this.errorMessage});

}