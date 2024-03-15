import 'dart:typed_data';

import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<String, dynamic>> searchText(Map<String, dynamic> params);
  Future<Either<String, dynamic>> chat(Map<String, dynamic> params);
  Future<Either<String, dynamic>> searchTextAndImage(
      Map<String, dynamic> params);
  Future<Either<String, Map<List<Uint8List>, List<String>>>> addMultipleImages();

  Stream<Either<String,dynamic>> generateContent(Map<String, dynamic> params);
}
