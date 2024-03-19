import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/src/search_text/domain/repository/search_repository.dart';
import 'package:gemini/src/sql_database/entities/text.dart';

class ReadData extends UseCases<List<TextEntity>?,NoParams> {
  final SearchRepository searchRepository;

  ReadData({required this.searchRepository});
  @override
  Future<Either<String, List<TextEntity>?>> call(NoParams params) async{

 return await searchRepository.readData();
    
  }
}
