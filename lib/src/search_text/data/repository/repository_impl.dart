import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/network_info.dart/network_info.dart';
import 'package:gemini/src/search_text/data/datasource/local_ds.dart';
import 'package:gemini/src/search_text/data/datasource/remote_ds.dart';
import 'package:gemini/src/search_text/domain/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final NetworkInfo networkInfo;
  final SearchRemoteDatasource searchRemoteDatasource;
  final SearchLocalDatasource searchLocalDatasource;
  SearchRepositoryImpl({
    required this.networkInfo,
    required this.searchRemoteDatasource,
    required this.searchLocalDatasource,
  });
  @override
  Future<Either<String, dynamic>> searchText(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await searchRemoteDatasource.searchText(params);
        if (response == null) {
          return const Left("Invalid request");
        }

        if (response.content == null || response.content.parts[0] == null) {
          return const Left("Invalid request");
        }
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future<Either<String, dynamic>> searchTextAndImage(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await searchRemoteDatasource.searchTextAndImage(params);
        if (response == null) {
          return const Left("Invalid request");
        }
        // if (response.content == null || response.content.parts[0] == null) {
        //   return const Left("Invalid request");
        // }
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future<Either<String, Map<List<Uint8List>, List<String>>>> addMultipleImages() async {
    try {
      final response = await searchLocalDatasource.images();
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Stream<Either<String, dynamic>> generateContent(
      Map<String, dynamic> params) async* {
    if (await networkInfo.isConnected) {
      try {
        final response = searchRemoteDatasource.generateContent(params);
       
        yield Right(response);
      } catch (e) {
        yield Left(e.toString());
      }
    } else {
      yield Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future<Either<String, dynamic>> chat(Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await searchRemoteDatasource.chat(params);
        if (response == null) {
          return const Left("Invalid request");
        }
        if (response.content == null || response.content.parts[0] == null) {
          return const Left("Invalid request");
        }
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }
}
