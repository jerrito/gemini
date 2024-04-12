import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/core/widgets/network_info.dart/network_info.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/src/search_text/data/datasource/remote_ds.dart';
import 'package:gemini/src/search_text/domain/usecase/add_multi_images.dart';
import 'package:gemini/src/search_text/domain/usecase/chat.dart';
import 'package:gemini/src/search_text/domain/usecase/generate_content.dart';
import 'package:gemini/src/search_text/domain/usecase/is_speech_text_enabled.dart';
import 'package:gemini/src/search_text/domain/usecase/listen_speech_text.dart';
import 'package:gemini/src/search_text/domain/usecase/on_speech_result.dart';
import 'package:gemini/src/search_text/domain/usecase/read_sql_data.dart';
import 'package:gemini/src/search_text/domain/usecase/search_text.dart';
import 'package:gemini/src/search_text/domain/usecase/search_text_image.dart';
import 'package:gemini/src/search_text/domain/usecase/stop_speech_text.dart';
import 'package:gemini/src/sql_database/entities/text.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:gemini/main.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
part "search_event.dart";
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchText searchText;
  final SearchTextAndImage searchTextAndImage;
  final AddMultipleImages addMultipleImage;
  final GenerateContent generateContent;
  final Chat chat;
  final ReadData readSQLData;
  final NetworkInfo networkInfo;
  // final OnSpeechResult onSpeechResult;
  // final StopSpeechText stopSpeechText;
  // final ListenSpeechText listenSpeechText;
  // final SpeechTextEnabled isSpeechTextEnabled;
  final SearchRemoteDatasourceImpl remoteDatasourceImpl;

  SearchBloc({
    // required this.onSpeechResult,
    // required this.stopSpeechText,
    // required this.listenSpeechText,
    // required this.isSpeechTextEnabled,
    required this.searchText,
    required this.networkInfo,
    required this.searchTextAndImage,
    required this.addMultipleImage,
    required this.generateContent,
    required this.chat,
    required this.readSQLData,
    required this.remoteDatasourceImpl,
  }) : super(SearchInitState()) {
    on<SearchTextEvent>((event, emit) async {
      emit(SearchTextLoading());

      final response = await searchText.call(event.params);

      emit(
        response.fold(
          (error) => SearchTextError(errorMessage: error),
          (response) => SearchTextLoaded(
            data: response.toString(),
          ),
        ),
      );
    });

    on<SearchTextAndImageEvent>((event, emit) async {
      emit(SearchTextAndImageLoading());

      final response = await searchTextAndImage.call(event.params);

      emit(response.fold(
          (error) => SearchTextAndImageError(errorMessage: error),
          (response) => SearchTextAndImageLoaded(data: response)));
    });

    on<AddMultipleImageEvent>((event, emit) async {
      emit(AddMultipleImageLoading());

      final response = await addMultipleImage.call(event.noParams);

      emit(response.fold(
        (error) => AddMultipleImageError(errorMessage: error),
        (response) => AddMultipleImageLoaded(
          data: response,
        ),
      ));
    });

    on<GenerateContentEvent>((event, emit) async {
      // StreamController s;
      await emit.forEach(
        generateContent.generateContent(event.params),
        onData: (data) {
          // String name="";
          final controller = StreamController<String>.broadcast();

          emit(GenerateContentLoading());
          // Stream<dynamic>  dataGet;

          return data.fold(
            (error) => GenerateContentError(
              errorMessage: error,
            ),
            (response) {
              //              await for (final chunk in response) {
              // controller.add(response.text!);
              //     print(chunk.text);
              //   }
              response.listen((event) {
                // print(event.text);
                controller.add(event.text!);
              });
              return GenerateContentLoaded(
                  data: response.first.then((value) => value.text));
            },
          );
        },
      );
    });

    on<GenerateStreamEvent>((event, emit) async {
      if (await networkInfo.isConnected) {
       try{ emit(GenerateStream());
       }catch(e){
         emit(GenerateStreamError(errorMessage:"",),);
       }}
       else{
       emit(GenerateStreamError(errorMessage:"",),);
      }

    });

    on<GenerateStreamStopEvent>((event, emit) {
      emit(GenerateStreamStop());
    });

    on<ChatEvent>((event, emit) async {
      emit(ChatLoading());
      final response = await chat.call(event.params);

      emit(
        response.fold(
          (error) => ChatError(errorMessage: error),
          (response) => ChatLoaded(data: response.toString()),
        ),
      );
    });
    on<ReadSQLDataEvent>((event, emit) async {
      emit(ReadDataLoading());
      final response = await readSQLData.call(NoParams());
      emit(
        response.fold(
          (error) => ReadDataError(errorMessage: error),
          (response) => ReadDataLoaded(
            data: response,
          ),
        ),
      );
    });

    on<ReadDataDetailsEvent>((event, emit) {
      final response = readDataDetails(event.params);
      emit(
        ReadDataDetailsLoaded(
          response,
        ),
      );
    });

    on<StopSpeechTextEvent>((event, emit) async {
      await stopSpeechText();
      emit(
        StopSpeechTextLoaded(),
      );
    });

    on<ListenSpeechTextEvent>((event, emit) async {
      await _speechToText.listen(
        listenFor: const Duration(seconds: 90),
        onResult: (result) {
          emit(
            OnSpeechResultLoaded(
              result: result.recognizedWords,
            ),
          );
          // print(result.recognizedWords);
        },
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.search,
        ),
      );

      //emit(ListenSpeechTextLoaded());
    });

    // on<OnSpeechResultEvent>((event, emit) {
    //   // final response = onSpeechResult.call();
    //   //emit(OnSpeechResultLoaded(result: response));
    // });

    on<IsSpeechTextEnabledEvent>((event, emit) async {
      try {
        final speechEnabled = await _speechToText.initialize();

        emit(IsSpeechTextEnabledLoaded(isSpeechTextEnabled: speechEnabled));
      } catch (e) {
        emit(IsSpeechTextEnabledError(
          errorMessage: "Your phone is not supported",
        ));
        throw PlatformException(
            code: "404", message: "Your phone is not supported");
      }
    });
  }

  final _speechToText = SpeechToText();

  /// This has to happen only once per app
  Future<bool> isSpeechTextEnabled() async {
    try {
      final speechEnabled = await _speechToText.initialize();
      return speechEnabled;
    } catch (e) {
      throw PlatformException(
          code: "404", message: "Your phone is not supported");
    }
  }

  // Future<bool> isSpeechTextHasPermission() async {
  //   final speechEnabled = await _speechToText.hasPermission();
  //   print(speechEnabled);
  //   return speechEnabled;
  // }

  /// Each time to start a speech recognition session
  Future<dynamic> listenToSpeechText() async {
    final response = await _speechToText.listen(
      onResult: onSpeechResult,
      listenOptions: SpeechListenOptions(listenMode: ListenMode.search),
    );
    return response;
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopSpeechText() async {
    return await _speechToText.stop();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  String onSpeechResult(SpeechRecognitionResult result) {
    print(result.recognizedWords);
    return result.recognizedWords;
  }

  Stream<GenerateContentResponse> generateStream(Map<String, dynamic> params) {
    return remoteDatasourceImpl.generateContent(params);
  }

  Future addData(Map<String, dynamic> params) async {
    final personDao = database?.textDao;
    final textEntity = TextEntity(
      textId: params["textId"],
      textTopic: params["textTopic"],
      textData: params["textData"],
      imageData: params["imageData"],
      dateTime: params["dateTime"],
      eventType: params["eventType"],
    );

    return await personDao?.insertData(textEntity);
    // final result = await personDao.getTextData();
  }

  Future deleteData(Map<String, dynamic> params) async {
    final textDao = database?.textDao;
    final textEntity = TextEntity(
      textId: params["textId"],
      textTopic: params["textTopic"],
      textData: params["textData"],
      imageData: params["imageData"],
      dateTime: params["dateTime"],
      eventType: params["eventType"],
    );

    return await textDao?.deleteData(textEntity);
  }

  Future<List<TextEntity>?> readData() async {
    final textData = database?.textDao;
    return await textData?.getAllTextData();
  }

  TextEntity? readDataDetails(Map<String, dynamic> params) {
    final textData = TextEntity(
      textId: params["textId"],
      textTopic: params["textTopic"],
      textData: params["textData"],
      imageData: params["imageData"],
      dateTime: params["dateTime"],
      eventType: params["eventType"],
    );
    return textData;
  }

  Future<void> copyText(Map<String, dynamic> params) async {
    await Clipboard.setData(ClipboardData(text: params["text"]));
  }
}
