

import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/src/search_text/domain/repository/search_repository.dart';

class AddMultipleImages extends UseCases<Map<List<Uint8List>, List<String>>,NoParams>{
 final SearchRepository repository;

  AddMultipleImages({required this.repository});
 
  @override
  Future<Either<String, Map<List<Uint8List>, List<String>>>> call(NoParams params) async{
    
  return await   repository.addMultipleImages();
  }

 
}