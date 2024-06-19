import 'package:dartz/dartz.dart';
import 'package:gemini/core/usecase/usecase.dart';
import 'package:gemini/features/authentication/domain/entities/authorization.dart';
import 'package:gemini/features/authentication/domain/repository/auth_repo.dart';

class GetToken extends UseCases<Authorization, NoParams> {
  final AuthenticationRepository repository;

  GetToken({required this.repository});
  
  @override
  Future<Either<String, Authorization>> call(NoParams params) async {
    return await repository.getToken();
  }
}
