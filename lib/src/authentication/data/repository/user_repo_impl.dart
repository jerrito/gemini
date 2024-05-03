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
  Future<Either<String, dynamic>> verifyToken(
      Map<String, dynamic> params) async {
    // TODO: implement verifyToken
    throw UnimplementedError();
  }

  @override
  Future<Either<String, bool>> confirmToken(Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await userRemoteDatasource.confirmToken(params);
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future<Either<String, dynamic>> getOTP(Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await userRemoteDatasource.getOTP(params);
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
  Future<Either<String, auth.UserCredential>> createUserWithEmailAndPassword(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await userRemoteDatasource.createUserWithEmailAndPassword(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future<Either<String, auth.UserCredential>> signinWithEmailPassword(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await userRemoteDatasource.signinWithEmailPassword(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future<Either<String, void>> signInWithEmailLink(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await userRemoteDatasource.signInWithEmailLink(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future<Either<String, bool>> isSignInWithEmailLink(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await userRemoteDatasource.isSignInWithEmailLink(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future<Either<String, dynamic>> cacheUserData(
       User userData) async {
    try {
      final data = await userLocalDatasource.cacheUserData(userData);
      return Right(data);
    } catch (e) {
      return Left(e.toString());
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
}
