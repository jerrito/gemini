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

class VerifyOtpEvent extends UserEvent {
  final Map<String, dynamic> params;
  VerifyOtpEvent({required this.params});
}


