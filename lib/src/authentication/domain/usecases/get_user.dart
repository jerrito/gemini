import 'package:dartz/dartz.dart';
import 'package:gemini/src/authentication/domain/repository/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetUserData  {
  final UserRepository repository;

  GetUserData({required this.repository});

  Future<Either<String, User>> getUserData() async {
    return await repository.getUserData();
  }
}
