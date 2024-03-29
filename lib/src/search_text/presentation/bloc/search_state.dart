part of 'search_bloc.dart';

class SearchState {}

class SearchInitState extends SearchState {}

class SearchTextLoading extends SearchState {}

class SearchTextLoaded extends SearchState {
  final String data;
  SearchTextLoaded({required this.data});
}

class SearchTextError extends SearchState {
  final String errorMessage;
  SearchTextError({required this.errorMessage});
}

class ChatLoading extends SearchState {}

class ChatLoaded extends SearchState {
  final String data;
  ChatLoaded({required this.data});
}

class ChatError extends SearchState {
  final String errorMessage;
  ChatError({required this.errorMessage});
}

class SearchTextAndImageLoading extends SearchState {}

class SearchTextAndImageLoaded extends SearchState {
  final dynamic data;
  SearchTextAndImageLoaded({required this.data});
}

class SearchTextAndImageError extends SearchState {
  final String errorMessage;
  SearchTextAndImageError({required this.errorMessage});
}

class GenerateContentLoading extends SearchState {}

class GenerateContentLoaded extends SearchState {
  final dynamic data;
  GenerateContentLoaded({required this.data});
}

class GenerateContentError extends SearchState {
  final String errorMessage;
  GenerateContentError({required this.errorMessage});
}


class AddMultipleImageLoading extends SearchState {}

class AddMultipleImageLoaded extends SearchState {
  final Map<List<Uint8List>, List<String>> data;
  
  AddMultipleImageLoaded({required this.data});
}

class AddMultipleImageError extends SearchState {
  final String errorMessage;
  AddMultipleImageError({required this.errorMessage});
}

class GenerateStream extends SearchState{}

class GenerateStreamStop extends SearchState{}

class ReadDataLoaded extends SearchState{
  final List<TextEntity>? data;

  ReadDataLoaded({required this.data});

}

class ReadDataLoading extends SearchState {}


class ReadDataError extends SearchState{
  final String errorMessage;
   ReadDataError({required this.errorMessage});
}

class ReadDataDetailsLoaded extends SearchState{

final TextEntity? textEntity;

 ReadDataDetailsLoaded(this.textEntity);
}
  
                    
                     
               
            