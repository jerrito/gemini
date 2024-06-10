import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/features/authentication/domain/repository/user_repository.dart';

class CacheToken extends UseCases<dynamic, String> {
  final UserRepository repository;

  CacheToken({required this.repository});
  @override
  Future<Either<String, dynamic>> call(String params) async {
    return await repository.cacheToken(params);
  }
}
