
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

