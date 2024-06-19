import 'package:dartz/dartz.dart';
import 'package:gemini/core/usecase/usecase.dart';
import 'package:gemini/features/authentication/data/models/authorization_model.dart';
import 'package:gemini/features/authentication/domain/entities/authorization.dart';
import 'package:gemini/features/authentication/domain/repository/auth_repo.dart';

class CacheToken extends UseCases<dynamic, AuthorizationModel> {
  final AuthenticationRepository repository;

  CacheToken({required this.repository});
  @override
  Future<Either<String, dynamic>> call(AuthorizationModel params) async {
    return await repository.cacheToken(params);
  }
}
