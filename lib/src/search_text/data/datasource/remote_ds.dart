import "dart:async";

import "package:flutter_gemini/flutter_gemini.dart";
import "package:gemini/core/widgets/network_info.dart/network_info.dart";

abstract class SearchRemoteDatasource {
  Future<dynamic> searchText(Map<String, dynamic> params);
  Future<dynamic> searchTextAndImage(Map<String, dynamic> params);
  Stream<dynamic> generateContent(Map<String, dynamic> params);
  Future<dynamic> chat(Map<String, dynamic> params);
}

class SearchRemoteDatasourceImpl implements SearchRemoteDatasource {
  final NetworkInfo networkInfo;
  final gemini = Gemini.instance;

  SearchRemoteDatasourceImpl({required this.networkInfo});

  @override
  Future searchText(Map<String, dynamic> params) async {
    return await gemini.text(params["text"], safetySettings: [
      SafetySetting(
          category: SafetyCategory.hateSpeech,
          threshold: SafetyThreshold.blockOnlyHigh)
    ]);
  }

  @override
  Future<dynamic> searchTextAndImage(Map<String, dynamic> params) {
    return gemini.textAndImage(
        text: params["text"],
        images: params["images"],
        modelName: "gemini-pro-vision");
  }

  @override
  Stream<dynamic> generateContent(Map<String, dynamic> params) async* {
    final controller = StreamController<String>.broadcast();

    final data = gemini.streamGenerateContent(params["text"]).listen((event) {
      controller.add(event.output!);
    });
    // print(controller.stream.first.then((value) => print(value.toString())));
    yield* controller.stream;
  }

  @override
  Future chat(Map<String, dynamic> params) async {
    return await gemini.chat(
      [
        Content(parts: [
          Parts(
            text: params["chats"],
          ),
        ], role: 'user'),
      ],
    );
  }
}
