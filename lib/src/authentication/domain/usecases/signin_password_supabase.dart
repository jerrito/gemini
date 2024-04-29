import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/src/authentication/domain/repository/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SigninPasswordSupabase extends UseCases<AuthResponse, Map<String, dynamic>> {
  final UserRepository repository;

  SigninPasswordSupabase({required this.repository});
  @override
  Future<Either<String, AuthResponse>> call(Map<String, dynamic> params) async {
    return await repository.signInPasswordSupabase(params);
  }
}
