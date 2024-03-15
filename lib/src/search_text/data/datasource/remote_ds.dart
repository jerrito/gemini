import "dart:async";

import "package:flutter_gemini/flutter_gemini.dart";
import "package:gemini/core/api/api_key.dart";
import "package:gemini/core/widgets/network_info.dart/network_info.dart";
import "package:google_generative_ai/google_generative_ai.dart" as ai;

abstract class SearchRemoteDatasource {
  Future<dynamic> searchText(Map<String, dynamic> params);
  Future<dynamic> searchTextAndImage(Map<String, dynamic> params);
  Stream<dynamic> generateContent(Map<String, dynamic> params);
  Future<dynamic> chat(Map<String, dynamic> params);
}

class SearchRemoteDatasourceImpl implements SearchRemoteDatasource {
  final NetworkInfo networkInfo;
  final gemini = Gemini.instance;
  final model = ai.GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);

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
  Future<dynamic> searchTextAndImage(Map<String, dynamic> params) async {
    final prompt = ai.TextPart(params["text"]);
    final imageParts = [
      ai.DataPart('image/${params["ext"]}', params["image"]),
    ];
    final response = await model.generateContent([
      ai.Content.multi([prompt, ...imageParts])
    ]);
    return response.text;
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
