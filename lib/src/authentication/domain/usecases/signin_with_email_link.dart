import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/src/authentication/domain/repository/user_repository.dart';

class SignInWithEmailLink extends UseCases<void, Map<String, dynamic>> {
  final UserRepository repository;

  SignInWithEmailLink({required this.repository});
  @override
  Future<Either<String, void>> call(Map<String, dynamic> params) async {
    return await repository.signInWithEmailLink(params);
  }
}
