import 'package:dartz/dartz.dart';
import 'package:gemini/src/authentication/domain/entities/user.dart';
import 'package:gemini/src/authentication/domain/repository/user_repository.dart';

class CacheUserData  {
  final UserRepository repository;

  CacheUserData({required this.repository});

  Future<Either<String, dynamic>> cacheUserData (User userData) async {
    return await repository.cacheUserData( userData);
  }
}
