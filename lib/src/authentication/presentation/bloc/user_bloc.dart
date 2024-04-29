import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/src/authentication/domain/entities/user.dart';
import 'package:gemini/src/authentication/domain/usecases/add_user.dart';
import 'package:gemini/src/authentication/domain/usecases/sign_otp_supabase.dart';
import 'package:gemini/src/authentication/domain/usecases/signin.dart';
import 'package:gemini/src/authentication/domain/usecases/get_otp.dart';
import 'package:gemini/src/authentication/domain/usecases/signin_password_supabase.dart';
import 'package:gemini/src/authentication/domain/usecases/signup.dart';
import 'package:gemini/src/authentication/domain/usecases/signup_supabase.dart';
import 'package:gemini/src/authentication/domain/usecases/verify_otp.dart';
import 'package:gemini/src/authentication/domain/usecases/get_user_from_token.dart';
import 'package:gemini/src/authentication/domain/usecases/confirm_token.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Signup signup;
  final Signin signin;
  final ConfirmToken confirmToken;
  final GetUserFromToken getUserFromToken;
  final GetOTP getOTP;
  final VerifyOTP verifyOTP;
  final SignupSupabase signupSupabase;
  final SigninPasswordSupabase signinPasswordSupabase;
  final SigninOTPSupabase signinOTPSupabase;
  final AddUserSupabase addUserSupabase;
  UserBloc({
    required this.signup,
    required this.signin,
    required this.confirmToken,
    required this.getUserFromToken,
    required this.verifyOTP,
    required this.addUserSupabase,
    required this.getOTP,
    required this.signupSupabase,
    required this.signinOTPSupabase,
    required this.signinPasswordSupabase,
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

        emit(response.fold((l) => GetUserFromTokenError(errorMessage: l),
            (r) => GetUserFromTokenLoaded(user: r)));
      },
    );

    on<VerifyOTPEvent>(
      (event, emit) async {
        emit(VerifyOTPLoading());
        final response = await verifyOTP.call(event.params);

        emit(response.fold((l) => VerifyOTPError(errorMessage: l),
            (r) => VerifyOTPLoaded(data: r)));
      },
    );
    on<SignupSupabaseEvent>(
      (event, emit) async {
        emit(SignupSupabaseLoading());
        final response = await signupSupabase.call(event.params);

        emit(response.fold((l) => SignupSupabaseError(errorMessage: l),
            (r) => SignupSupabaseLoaded(data: r)));
      },
    );

    on<SigninPasswordSupabaseEvent>(
      (event, emit) async {
        emit(SigninPasswordSupabaseLoading());
        final response = await signinPasswordSupabase.call(event.params);

        emit(response.fold((l) => SigninPasswordSupabaseError(errorMessage: l),
            (r) => SigninPasswordSupabaseLoaded(data: r)));
      },
    );

    on<SigninOTPSupabaseEvent>(
      (event, emit) async {
        emit(SigninOTPSupabaseLoading());
        final response = await signinOTPSupabase.call(event.params);

        emit(response.fold((l) => SigninOTPSupabaseError(errorMessage: l),
            (r) => SigninOTPSupabaseLoaded()));
      },
    );
    on<AddUserSupabaseEvent>(
      (event, emit) async {
        emit(AddUserSupabaseLoading());
        final response = await addUserSupabase.call(event.params);

        emit(
          response.fold(
            (l) => AddUserSupabaseError(errorMessage: l),
            (r) => AddUserSupabaseLoaded(data: r),
          ),
        );
      },
    );
  }
}
