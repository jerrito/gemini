import 'package:dartz/dartz.dart';
import 'package:gemini/core/usecase/usecase.dart';
import 'package:gemini/features/authentication/domain/entities/user.dart';
import 'package:gemini/features/authentication/domain/repository/user_repository.dart';

class Signin extends UseCases<Data, Map<String, dynamic>> {
  final UserRepository repository;

  Signin({required this.repository});
  @override
  Future<Either<String, Data>> call(Map<String, dynamic> params) async {
    return await repository.signin(params);
  }
}
