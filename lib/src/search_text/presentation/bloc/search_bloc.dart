import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/src/search_text/data/datasource/remote_ds.dart';
import 'package:gemini/src/search_text/domain/usecase/add_multi_images.dart';
import 'package:gemini/src/search_text/domain/usecase/chat.dart';
import 'package:gemini/src/search_text/domain/usecase/generate_content.dart';
import 'package:gemini/src/search_text/domain/usecase/search_text.dart';
import 'package:gemini/src/search_text/domain/usecase/search_text_image.dart';
import 'package:gemini/src/sql_database/database/text_database.dart';
import 'package:gemini/src/sql_database/entities/text.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:gemini/main.dart';
part "search_event.dart";
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchText searchText;
  final SearchTextAndImage searchTextAndImage;
  final AddMultipleImages addMultipleImage;
  final GenerateContent generateContent;
  final Chat chat;
  final SearchRemoteDatasourceImpl remoteDatasourceImpl;

  SearchBloc({
    required this.searchText,
    required this.searchTextAndImage,
    required this.addMultipleImage,
    required this.generateContent,
    required this.chat,
    required this.remoteDatasourceImpl,
  }) : super(SearchInitState()) {
    on<SearchTextEvent>((event, emit) async {
      emit(SearchTextLoading());

      final response = await searchText.call(event.params);

      emit(response.fold((error) => SearchTextError(errorMessage: error),
          (response) => SearchTextLoaded(data: response)));
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
                print(event.text);
                controller.add(event.text!);
              });
              return GenerateContentLoaded(
                  data: response.first.then((value) => print(value.text)));
            },
          );
        },
      );
    });

    on<GenerateStreamEvent>((event, emit) {
      emit(GenerateStream());
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
          (response) => ChatLoaded(data: response),
        ),
      );
    });
  }
  Stream<GenerateContentResponse> generateStream(Map<String, dynamic> params) {
    return remoteDatasourceImpl.generateContent(params);
  }

  Future addData(Map<String, dynamic> params) async {
     AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final personDao = database.textDao;
    final textEntity = TextEntity(
        textId: params["text_id"],
        textTopic: params["text_topic"],
        textData: params["text_data"]);

   return await personDao.insertData(textEntity);
   // final result = await personDao.getTextData();
  }

   Future<List<TextEntity>> readData() async {
     AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final textData = database.textDao;
    

   return await textData.getAllTextData();
   // final result = await personDao.getTextData();
  }
}
