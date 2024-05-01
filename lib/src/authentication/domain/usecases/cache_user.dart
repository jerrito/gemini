import 'package:dartz/dartz.dart';
import 'package:gemini/src/authentication/domain/entities/user.dart' as u;
import 'package:gemini/src/authentication/domain/repository/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CacheUserData  {
  final UserRepository repository;

  CacheUserData({required this.repository});

  Future<Either<String, dynamic>> cacheUserData(User user, u.User userData) async {
    return await repository.cacheUserData(user, userData);
  }
}
