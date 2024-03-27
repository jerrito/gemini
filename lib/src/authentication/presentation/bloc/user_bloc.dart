import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/src/authentication/domain/entities/user.dart';
import 'package:gemini/src/authentication/domain/usecases/signup.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBLoc extends Bloc<UserEvent, UserState> {
  final Signup signup;
  UserBLoc({required  this.signup}):super(InitState()) {
   
   
    on<SignupEvent>(
      (event, emit) {},
    );

      }
}
