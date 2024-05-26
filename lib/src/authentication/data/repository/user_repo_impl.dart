import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:gemini/core/widgets/network_info.dart/network_info.dart';
import 'package:gemini/src/authentication/data/data_source/local_ds.dart';
import 'package:gemini/src/authentication/data/data_source/remote_ds.dart';
import 'package:gemini/src/authentication/domain/entities/user.dart';
import 'package:gemini/src/authentication/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final UserRemoteDatasource userRemoteDatasource;
  final UserLocalDatasource userLocalDatasource;

  UserRepositoryImpl(
      {required this.userLocalDatasource,
      required this.userRemoteDatasource,
      required this.networkInfo});

  @override
  Future<Either<String, User>> signin(Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await userRemoteDatasource.signinUser(params);
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future<Either<String, User>> signup(Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await userRemoteDatasource.signupUser(params);
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }




  @override
  Future<Either<String, User>> getUserFromToken(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await userRemoteDatasource.getUserFromToken(params);
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }


  @override
  Future<Either<String, User>> getUserData() async {
    try {
      final data = await userLocalDatasource.getUserData();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, dynamic>> cacheToken(String token) async {
    try {
      final response = await userLocalDatasource.cacheToken(token);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> getToken()async {
   try {
      final response = await userLocalDatasource.getToken();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
  
  @override
  Future<Either<String,User>> getUser(Map<String, dynamic> params) async{
     if (await networkInfo.isConnected) {
      try {
        final response =
            await userRemoteDatasource.getUser(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }
  
  @override
  Future<Either<String, dynamic>> cacheUserData(Map<String, dynamic> params)async {
     try {
        final response =
            await userRemoteDatasource.getUser(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
  }
}
