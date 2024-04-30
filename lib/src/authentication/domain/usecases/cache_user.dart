import 'package:dartz/dartz.dart';
import 'package:gemini/src/authentication/domain/repository/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CacheUserData  {
  final UserRepository repository;

  CacheUserData({required this.repository});

  Future<Either<String, User>> cacheUserData(User user) async {
    return await repository.cacheUserData(user);
  }
}
