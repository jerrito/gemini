import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/network_info.dart/network_info.dart';
import 'package:gemini/src/authentication/data/data_source/remote_ds.dart';
import 'package:gemini/src/authentication/domain/entities/user.dart';
import 'package:gemini/src/authentication/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfoImpl networkInfo;
  final UserRemoteDatasourceImpl userRemoteDatasource;

  UserRepositoryImpl(
      {required this.userRemoteDatasource, required this.networkInfo});

  @override
  Future<Either<String, User>> signin(Map<String, dynamic> params) async {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<Either<String, User>> signup(Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response =await userRemoteDatasource.signupUser(params);
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
}
