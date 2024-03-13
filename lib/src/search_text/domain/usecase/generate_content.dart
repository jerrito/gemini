import 'package:dartz/dartz.dart';
import 'package:gemini/src/search_text/domain/repository/search_repository.dart';

class GenerateContent  {
  final SearchRepository repository;

  GenerateContent({required this.repository});
 
  Stream<Either<String, dynamic>> generateContent(Map<String, dynamic> params) async*{
    yield*  repository.generateContent(params); 
  }
}
