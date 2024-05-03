import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/src/authentication/domain/repository/user_repository.dart';

class SigninWithEmailPassword
    extends UseCases<UserCredential, Map<String, dynamic>> {
  final UserRepository repository;

  SigninWithEmailPassword({required this.repository});
  @override
  Future<Either<String, UserCredential>> call(
      Map<String, dynamic> params) async {
    return await repository.signinWithEmailPassword(params);
  }
}
