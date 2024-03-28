part of  'user_bloc.dart';

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


