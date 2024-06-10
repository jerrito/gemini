import 'package:dartz/dartz.dart';
import 'package:gemini/features/authentication/domain/entities/user.dart';
import 'package:gemini/features/authentication/domain/repository/user_repository.dart';

class CacheUserData  {
  final UserRepository repository;

  CacheUserData({required this.repository});

  Future<Either<String, dynamic>> cacheUserData (Map<String, dynamic> params) async {
    return await repository.cacheUserData( params);
  }
}
