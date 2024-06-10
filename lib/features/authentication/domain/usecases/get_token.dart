import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/features/authentication/domain/repository/user_repository.dart';

class GetToken extends UseCases<String, NoParams> {
  final UserRepository repository;

  GetToken({required this.repository});
  
  @override
  Future<Either<String, String>> call(NoParams params) async {
    return await repository.getToken();
  }
}
