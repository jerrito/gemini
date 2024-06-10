import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/features/authentication/domain/entities/user.dart';
import 'package:gemini/features/authentication/domain/usecases/cache_token.dart';
import 'package:gemini/features/authentication/domain/usecases/get_token.dart';
import 'package:gemini/features/authentication/domain/usecases/cache_user.dart';
import 'package:gemini/features/authentication/domain/usecases/get_user.dart';
import 'package:gemini/features/authentication/domain/usecases/signin.dart';
import 'package:gemini/features/authentication/domain/usecases/signup.dart';
import 'package:gemini/features/authentication/domain/usecases/get_user_from_token.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Signup signup;
  final Signin signin;
  final GetUserFromToken getUserFromToken;
  final CacheUserData cacheUserData;
  final GetUserData getUserData;
  final CacheToken cacheToken;
  final GetToken getToken;

  AuthenticationBloc({
    required this.signup,
    required this.signin,
    required this.getUserFromToken,
    required this.getUserData,
    required this.cacheUserData,
    required this.cacheToken,
    required this.getToken,
  }) : super(InitState()) {
    on<SignupEvent>(
      (event, emit) async {
        emit(SignupLoading());
        final response = await signup.call(event.params);

        emit(response.fold(
            (error) => SignupError(errorMessage: error), 
            (response) => SignupLoaded(user: response)));
      },
    );

    on<SigninEvent>(
      (event, emit) async {
        emit(SigninLoading());
        final response = await signin.call(event.params);

        emit(
          response.fold(
            (error) => SigninError(
              errorMessage: error,
            ),
            (response) => SigninLoaded(
              data: response,
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

    //! CACHE DATA
    on<CacheUserDataEvent>((event, emit) async {
      //  emit(CacheUserDataLoading());
      final response = await cacheUserData.cacheUserData(event.params);

      emit(
        response.fold(
          (l) => CacheUserDataError(errorMessage: l),
          (r) => CacheUserDataLoaded(),
        ),
      );
    });

    //! GET CACHED DATA
    // on<GetUserCacheDataEvent>(
    //   (event, emit) async {
    //     //emit(GetUserDataLoading());
    //     final response = await get.call();

    //     emit(
    //       response.fold(
    //         (l) => GetUserCacheDataError(errorMessage: l),
    //         (r) => GetUserCachedDataLoaded(user: r),
    //       ),
    //     );
    //   },
    // );
    on<GetUserEvent>((event, emit) async {
      emit(GetUserDataLoading());
      final response = await getUserData.call(event.params);
      response.fold(
        (error) => emit(
          GetUserError(errorMessage: error),
        ),
        (response) => emit(
          GetUserLoaded(
            user: response,
          ),
        ),
      );
    });
    on<CacheTokenEvent>((event, emit) async {
      final response = await cacheToken.call(event.token);
      emit(
        response.fold(
          (errorMessage) => CacheTokenError(errorMessage: errorMessage),
          (response) => CacheTokenLoaded(token: response),
        ),
      );
    });

    on<GetTokenEvent>((event, emit) async {
      final response = await getToken.call(NoParams());
      emit(
        response.fold(
          (errorMessage) => GetTokenError(errorMessage: errorMessage),
          (response) => GetTokenLoaded(
            token: response,
          ),
        ),
      );
    });
  }
}