import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/src/authentication/domain/repository/user_repository.dart';

class ConfirmToken extends UseCases<bool, Map<String, dynamic>> {
  final UserRepository repository;

  ConfirmToken({required this.repository});
  @override
  Future<Either<String, bool>> call(Map<String, dynamic> params) async {
    return await repository.confirmToken(params);
  }
}
