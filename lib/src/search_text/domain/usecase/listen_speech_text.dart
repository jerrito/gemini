import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/src/search_text/domain/repository/search_repository.dart';

class ListenSpeechText extends UseCases<dynamic, NoParams> {
  final SearchRepository repository;

  ListenSpeechText({required this.repository});

  @override
  Future<Either<String, dynamic>> call(NoParams params) async {
    return await repository.listenToSpeechText();
  }
}
