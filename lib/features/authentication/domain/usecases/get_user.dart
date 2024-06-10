import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/features/authentication/domain/entities/user.dart';
import 'package:gemini/features/authentication/domain/repository/user_repository.dart';

class GetUserData extends UseCases<User, Map<String, dynamic>> {
  final UserRepository repository;

  GetUserData({required this.repository});

  @override
  Future<Either<String, User>> call(Map<String, dynamic> params)async{
    return await repository.getUser(params);
  }
}
