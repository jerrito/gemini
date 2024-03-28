import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/src/authentication/domain/entities/user.dart';
import 'package:gemini/src/authentication/domain/usecases/signin.dart';
import 'package:gemini/src/authentication/domain/usecases/get_otp.dart';
import 'package:gemini/src/authentication/domain/usecases/signup.dart';
import 'package:gemini/src/authentication/domain/usecases/verify_otp.dart';
import 'package:gemini/src/authentication/domain/usecases/get_user_from_token.dart';
import 'package:gemini/src/authentication/domain/usecases/confirm_token.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Signup signup;
  final Signin signin;
  final ConfirmToken confirmToken;
  final GetUserFromToken getUserFromToken;
  final GetOTP getOTP;
  final VerifyOTP verifyOTP;
  UserBloc({
    required this.signup,
    required this.signin,
    required this.confirmToken,
    required this.getUserFromToken,
    required this.verifyOTP,
    required this.getOTP,
  }) : super(InitState()) {
    on<SignupEvent>(
      (event, emit) async {
        emit(SignupLoading());
        final response = await signup.call(event.params);

        emit(response.fold(
            (l) => SignupError(errorMessage: l), (r) => SignupLoaded(user: r)));
      },
    );

    on<SigninEvent>(
      (event, emit) async {
        emit(SigninLoading());
        final response = await signin.call(event.params);

        emit(response.fold(
            (l) => SigninError(errorMessage: l), (r) => SigninLoaded(user: r)));
      },
    );

    on<ConfirmTokenEvent>(
      (event, emit) async {
        emit(ConfirmTokenLoading());
        final response = await confirmToken.call(event.params);

        emit(
          response.fold(
            (l) => ConfirmTokenError(errorMessage: l),
            (r) => ConfirmTokenLoaded(
              confirm: r,
            ),
          ),
        );
      },
    );

    on<GetUserFromTokenEvent>(
      (event, emit) async {
        emit(GetUserFromTokenLoading());
        final response = await getUserFromToken.call(event.params);

        emit(response.fold(
            (l) => GetUserFromTokenError(errorMessage: l),
             (r) => GetUserFromTokenLoaded(user: r)));
      },
    );

    on<VerifyOTPEvent>(
      (event, emit) async {
        emit(VerifyOTPLoading());
        final response = await verifyOTP.call(event.params);

        emit(response.fold(
            (l) => VerifyOTPError(errorMessage: l),
             (r) => VerifyOTPLoaded(data: r)));
      },
    );
  }
}
