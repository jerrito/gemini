import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/src/authentication/domain/entities/user.dart';

import 'package:gemini/src/authentication/domain/repository/user_repository.dart';

class Signup extends UseCases<User, Map<String, dynamic>> {
  final UserRepository repository;

  Signup({required this.repository});
  @override
  Future<Either<String, User>> call(Map<String, dynamic> params)async {
    return await repository.signup(params);
  }
}
