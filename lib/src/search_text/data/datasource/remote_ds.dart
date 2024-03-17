import "dart:async";

import "package:flutter_gemini/flutter_gemini.dart";
import "package:gemini/core/api/api_key.dart";
import "package:gemini/core/widgets/network_info.dart/network_info.dart";
import "package:google_generative_ai/google_generative_ai.dart" as ai;

abstract class SearchRemoteDatasource {
  Future<dynamic> searchText(Map<String, dynamic> params);
  Future<dynamic> searchTextAndImage(Map<String, dynamic> params);
  Stream<ai.GenerateContentResponse> generateContent(
      Map<String, dynamic> params);
  Future<dynamic> chat(Map<String, dynamic> params);
}

class SearchRemoteDatasourceImpl implements SearchRemoteDatasource {
  final NetworkInfo networkInfo;
  final gemini = Gemini.instance;
  final model = ai.GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

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
    final imageParts =
        // params["images"].map(
        //   (e)=>ai.DataPart('image/${params["ext"][e]}', params["image"][e])
        // ).toList();
        [
      ai.DataPart('image/${params["ext"]}', params["image"]),
    ];
    final response = await model.generateContent([
      ai.Content.multi([prompt, ...imageParts])
    ]);
    return response.text;
  }

  @override
  Stream<ai.GenerateContentResponse> generateContent(
      Map<String, dynamic> params) async* {
    
      final content = [ai.Content.text(params["text"])];
    
      final response = model.generateContentStream(content,
      safetySettings: [
        ai.SafetySetting( ai.HarmCategory.dangerousContent,
         ai.HarmBlockThreshold.none)
      ]);
    
      yield* response.asBroadcastStream();
    
    // else{
    // throw ai.GenerativeAIException(
    //   "Invalid input"
    // );
    // }
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
