import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:gemini/core/widgets/network_info.dart/network_info.dart';
import 'package:gemini/src/search_text/data/datasource/local_ds.dart';
import 'package:gemini/src/search_text/data/datasource/remote_ds.dart';
import 'package:gemini/src/search_text/data/repository/repository_impl.dart';
import 'package:gemini/src/search_text/domain/repository/search_repository.dart';
import 'package:gemini/src/search_text/domain/usecase/add_multi_images.dart';
import 'package:gemini/src/search_text/domain/usecase/chat.dart';
import 'package:gemini/src/search_text/domain/usecase/generate_content.dart';
import 'package:gemini/src/search_text/domain/usecase/search_text.dart';
import 'package:gemini/src/search_text/domain/usecase/search_text_image.dart';
import 'package:gemini/src/search_text/presentation/bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initDependencies() {
  //bloc

  sl.registerFactory(
    () => SearchBloc(
      searchText: sl(),
      searchTextAndImage: sl(),
      addMultipleImage: sl(),
      generateContent: sl(),
      chat: sl(),
      remoteDatasourceImpl: sl()
    ),
  );

  //usecases

  sl.registerLazySingleton<SearchRemoteDatasourceImpl>(
    () => SearchRemoteDatasourceImpl(
      networkInfo: sl(),
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
    () => SearchRemoteDatasourceImpl(
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<SearchLocalDatasource>(
    () => SearchLocalDatasourceImpl(),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      dataConnectionChecker: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => DataConnectionChecker(),
  );
}
