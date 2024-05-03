import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/src/authentication/domain/entities/user.dart';
import 'package:gemini/src/authentication/domain/usecases/is_email_link.dart';
import 'package:gemini/src/authentication/domain/usecases/cache_user.dart';
import 'package:gemini/src/authentication/domain/usecases/get_user.dart';
import 'package:gemini/src/authentication/domain/usecases/signin_email_password.dart';
import 'package:gemini/src/authentication/domain/usecases/signin.dart';
import 'package:gemini/src/authentication/domain/usecases/get_otp.dart';
import 'package:gemini/src/authentication/domain/usecases/signin_with_email_link.dart';
import 'package:gemini/src/authentication/domain/usecases/signup.dart';
import 'package:gemini/src/authentication/domain/usecases/create_user.dart';
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
  final CreateUserWithEmailAndPassword createUserWithEmailAndPassword;
  final SignInWithEmailLink signInWithEmailLink;
  final SigninWithEmailPassword signinWithEmailPassword;
  final IsSignInWithEmailLink isSignInWithEmailLink;
  final CacheUserData cacheUserData;
  final GetUserData getUserData;
  UserBloc({
    required this.signup,
    required this.signin,
    required this.confirmToken,
    required this.getUserFromToken,
    required this.verifyOTP,
    required this.isSignInWithEmailLink,
    required this.getOTP,
    required this.createUserWithEmailAndPassword,
    required this.signinWithEmailPassword,
    required this.signInWithEmailLink,
    required this.getUserData,
    required this.cacheUserData,
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
        emit(CreateUserWithEmailAndPasswordLoading());
        final response =
            await createUserWithEmailAndPassword.call(event.params);

        emit(response.fold(
            (l) => CreateUserWithEmailAndPasswordError(errorMessage: l),
            (r) => CreateUserWithEmailAndPasswordLoaded(data: r)));
      },
    );

    on<SigninPasswordSupabaseEvent>(
      (event, emit) async {
        emit(SignInWithEmailLinkLoading());
        final response = await signInWithEmailLink.call(event.params);

        emit(response.fold((l) => SignInWithEmailLinkError(errorMessage: l),
            (r) => SignInWithEmailLinkLoaded()));
      },
    );

    on<SigninOTPSupabaseEvent>(
      (event, emit) async {
        emit(SigninWithEmailPasswordLoading());
        final response = await signinWithEmailPassword.call(event.params);

        emit(response.fold((l) => SigninWithEmailPasswordError(errorMessage: l),
            (r) => SigninWithEmailPasswordLoaded(data: r)));
      },
    );

    on<AddUserSupabaseEvent>((event, emit) async {
      emit(IsSignInWithEmailLinkLoading());
      final response = await isSignInWithEmailLink.call(event.params);

      emit(
        response.fold(
          (l) => IsSignInWithEmailLinkError(errorMessage: l),
          (r) => IsSignInWithEmailLinkLoaded(data: r),
        ),
      );
    });
    //! CACHE DATA
    on<CacheUserDataEvent>((event, emit) async {
      //  emit(CacheUserDataLoading());
      final response = await cacheUserData.cacheUserData(event.userData);

      emit(
        response.fold(
          (l) => CacheUserDataError(errorMessage: l),
          (r) => CacheUserDataLoaded(),
        ),
      );
    });

    //! GET CACHED DATA
    on<GetUserCacheDataEvent>(
      (event, emit) async {
        //emit(GetUserDataLoading());
        final response = await getUserData.getUserData();

        emit(
          response.fold(
            (l) => GetUserCacheDataError(errorMessage: l),
            (r) => GetUserCachedDataLoaded(user: r),
          ),
        );
      },
    );
  }
}
