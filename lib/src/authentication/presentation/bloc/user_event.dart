part of 'user_bloc.dart';

sealed class UserEvent {}

class SignupEvent extends UserEvent {
  final Map<String, dynamic> params;
  SignupEvent({required this.params});
}

class SigninEvent extends UserEvent {
  final Map<String, dynamic> params;
  SigninEvent({required this.params});
}

class GetUserFromTokenEvent extends UserEvent {
  final Map<String, dynamic> params;
  GetUserFromTokenEvent({required this.params});
}

class CreateUserWithEmailAndPasswordEvent extends UserEvent {
  final Map<String, dynamic> params;
  CreateUserWithEmailAndPasswordEvent({required this.params});
}



class CacheUserDataEvent extends UserEvent {
  final Map<String, dynamic> params;

  CacheUserDataEvent({required this.params});
}

class GetUserCacheDataEvent extends UserEvent {
  GetUserCacheDataEvent();
}

class CacheTokenEvent extends UserEvent {
  final String token;
  CacheTokenEvent({required this.token});
}

class GetTokenEvent extends UserEvent {
  GetTokenEvent();
}
