import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:gemini/core/widgets/network_info.dart/network_info.dart';
import 'package:gemini/src/authentication/data/data_source/remote_ds.dart';
import 'package:gemini/src/authentication/data/repository/user_repo_impl.dart';
import 'package:gemini/src/authentication/domain/repository/user_repository.dart';
import 'package:gemini/src/authentication/domain/usecases/confirm_token.dart';
import 'package:gemini/src/authentication/domain/usecases/get_otp.dart';
import 'package:gemini/src/authentication/domain/usecases/get_user_from_token.dart';
import 'package:gemini/src/authentication/domain/usecases/signin.dart';
import 'package:gemini/src/authentication/domain/usecases/signup.dart';
import 'package:gemini/src/authentication/domain/usecases/verify_otp.dart';
import 'package:gemini/src/authentication/presentation/bloc/user_bloc.dart';
import 'package:gemini/src/search_text/data/datasource/local_ds.dart';
import 'package:gemini/src/search_text/data/datasource/remote_ds.dart';
import 'package:gemini/src/search_text/data/repository/repository_impl.dart';
import 'package:gemini/src/search_text/domain/repository/search_repository.dart';
import 'package:gemini/src/search_text/domain/usecase/add_multi_images.dart';
import 'package:gemini/src/search_text/domain/usecase/chat.dart';
import 'package:gemini/src/search_text/domain/usecase/generate_content.dart';
import 'package:gemini/src/search_text/domain/usecase/read_sql_data.dart';
import 'package:gemini/src/search_text/domain/usecase/search_text.dart';
import 'package:gemini/src/search_text/domain/usecase/search_text_image.dart';
import 'package:gemini/src/search_text/presentation/bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

void initDependencies() async {
  //auth
  initAuthentication();

  //search
  initSearch();

  //! External

  //http
  sl.registerLazySingleton(() => http.Client());

  //network
  sl.registerLazySingleton(
    () => NetworkInfoImpl(
      dataConnectionChecker: sl(),
    ),
  );
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      dataConnectionChecker: sl(),
    ),
  );

  //data connection
  sl.registerLazySingleton(
    () => DataConnectionChecker(),
  );

  //shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
}

void initSearch() {
  //bloc
  sl.registerFactory(
    () => SearchBloc(
        searchText: sl(),
        searchTextAndImage: sl(),
        addMultipleImage: sl(),
        generateContent: sl(),
        chat: sl(),
        remoteDatasourceImpl: sl(),
        readSQLData: sl(),
        networkInfo: sl(),
        ),
  );

  sl.registerLazySingleton(
    () => SearchRemoteDatasourceImpl(),
  );

  //usecases

  sl.registerLazySingleton(
    () => ReadData(
      searchRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => SearchText(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => Chat(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GenerateContent(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => SearchTextAndImage(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => AddMultipleImages(
      repository: sl(),
    ),
  );

  //repository
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      networkInfo: sl(),
      searchRemoteDatasource: sl(),
      searchLocalDatasource: sl(),
    ),
  );

  //data source

  sl.registerLazySingleton<SearchRemoteDatasource>(
    () => SearchRemoteDatasourceImpl(),
  );

  sl.registerLazySingleton<SearchLocalDatasource>(
    () => SearchLocalDatasourceImpl(),
  );

  // sl.registerLazySingleton<NetworkInfo>(
  //   () => NetworkInfoImpl(
  //     dataConnectionChecker: sl(),
  //   ),
  // );

  // sl.registerLazySingleton(
  //   () => DataConnectionChecker(),
  // );
}

void initAuthentication() {
  //bloc

  sl.registerFactory(
    () => UserBloc(
      signin: sl(),
      signup: sl(),
      confirmToken: sl(),
      getOTP: sl(),
      getUserFromToken: sl(),
      verifyOTP: sl(),
    ),
  );

  //usecases

  sl.registerLazySingleton(
    () => GetUserFromToken(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetOTP(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => VerifyOTP(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => ConfirmToken(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => Signin(
      repository: sl(),
    ),
  );
  
  sl.registerLazySingleton(
    () => Signup(
      repository: sl(),
    ),
  );

  //repository

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      userRemoteDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  // datasources
  sl.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasourceImpl(
      client: sl(),
    ),
  );
}
