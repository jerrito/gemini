import 'package:dartz/dartz.dart';
import 'package:gemini/core/usecase/usecase.dart';
import 'package:gemini/features/authentication/domain/repository/auth_repo.dart';

class GetToken extends UseCases<String, NoParams> {
  final AuthenticationRepository repository;

  GetToken({required this.repository});
  
  @override
  Future<Either<String, String>> call(NoParams params) async {
    return await repository.getToken();
  }
}
