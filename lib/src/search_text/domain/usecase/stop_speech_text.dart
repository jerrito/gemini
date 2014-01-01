import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/src/search_text/domain/repository/search_repository.dart';

class StopSpeechText extends UseCases<void, NoParams> {
  final SearchRepository repository;

  StopSpeechText({required this.repository});

  @override
  Future<Either<String, void>> call(NoParams params) async {
    return await repository.stopSpeechText();
  }
}
