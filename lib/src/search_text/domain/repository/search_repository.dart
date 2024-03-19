import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:gemini/src/sql_database/entities/text.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

abstract class SearchRepository {
  Future<Either<String, dynamic>> searchText(Map<String, dynamic> params);
  Future<Either<String, dynamic>> chat(Map<String, dynamic> params);
  Future<Either<String, dynamic>> searchTextAndImage(
      Map<String, dynamic> params);
  Future<Either<String, Map<List<Uint8List>, List<String>>>>
      addMultipleImages();

  Stream<Either<String, Stream<GenerateContentResponse>>> generateContent(
      Map<String, dynamic> params);

  Future<Either<String,List<TextEntity>?>> readData();
}
