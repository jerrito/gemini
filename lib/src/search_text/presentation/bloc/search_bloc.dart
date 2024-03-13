import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/src/search_text/domain/usecase/add_multi_images.dart';
import 'package:gemini/src/search_text/domain/usecase/chat.dart';
import 'package:gemini/src/search_text/domain/usecase/generate_content.dart';
import 'package:gemini/src/search_text/domain/usecase/search_text.dart';
import 'package:gemini/src/search_text/domain/usecase/search_text_image.dart';
part "search_event.dart";
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchText searchText;
  final SearchTextAndImage searchTextAndImage;
  final AddMultipleImages addMultipleImage;
  final GenerateContent generateContent;
  final Chat chat;

  SearchBloc({
    required this.searchText,
    required this.searchTextAndImage,
    required this.addMultipleImage,
    required this.generateContent,
    required this.chat,
  }) : super(SearchInitState()) {
    on<SearchTextEvent>((event, emit) async {
      emit(SearchTextLoading());

      final response = await searchText.call(event.params);

      emit(response.fold((error) => SearchTextError(errorMessage: error),
          (response) => SearchTextLoaded(data: response)));
    });

    on<SearchTextAndImageEvent>((event, emit) async {
      emit(SearchTextAndImageLoading());

      final response = await searchText.call(event.params);

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
          emit(GenerateContentLoading());
          // Stream<dynamic>  dataGet;

          return data.fold(
            (error) => GenerateContentError(
              errorMessage: error,
            ),
            (response) {
               print(response.toString());
              // response.listen((event) {
              //   print(event.output);
              //   // print("event.outputs");
              //   controller.add(event.output!);
              // });
              return GenerateContentLoaded(data: response);
            },
          );
        },
      );
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
}
