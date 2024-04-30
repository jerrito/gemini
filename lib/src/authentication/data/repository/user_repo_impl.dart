import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/network_info.dart/network_info.dart';
import 'package:gemini/src/authentication/data/data_source/local_ds.dart';
import 'package:gemini/src/authentication/data/data_source/remote_ds.dart';
import 'package:gemini/src/authentication/domain/entities/user.dart';
import 'package:gemini/src/authentication/domain/repository/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final UserRemoteDatasource userRemoteDatasource;
  final UserLocalDatasource userLocalDatasource;

  UserRepositoryImpl({required this.userLocalDatasource,
      required this.userRemoteDatasource, required this.networkInfo});

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
  Future<Either<String, supabase.AuthResponse>> signUpSupabase(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await userRemoteDatasource.signUpSupabase(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future<Either<String, void>> signInOTPSupabase(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await userRemoteDatasource.signInOTPSupabase(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future<Either<String, supabase.AuthResponse>> signInPasswordSupabase(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await userRemoteDatasource.signInPasswordSupabase(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
  Future addUserSupabase(Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await userRemoteDatasource.addUserSupabase(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }

  @override
   Future<Either<String,supabase.User>> cacheUserData(supabase.User user, String userName) async {
    try {
      final data = await userLocalDatasource.cacheUserData(user, userName);
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, supabase.User>> getUserData() async{
    try {
      final data =await userLocalDatasource.getUserData();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
