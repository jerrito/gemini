import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/src/authentication/domain/repository/user_repository.dart';

class GetUserFromToken extends UseCases<dynamic, Map<String, dynamic>> {
  final UserRepository repository;

  GetUserFromToken({required this.repository});
  @override
  Future<Either<String, dynamic>> call(Map<String, dynamic> params) async {
    return await repository.getUserFromToken(params);
  }
}
