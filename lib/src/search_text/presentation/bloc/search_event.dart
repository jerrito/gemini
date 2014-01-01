part of 'search_bloc.dart';

class SearchEvent {}

class SearchTextEvent extends SearchEvent {
  final Map<String, dynamic> params;
  SearchTextEvent({required this.params});
}

class SearchTextAndImageEvent extends SearchEvent {
  final Map<String, dynamic> params;
  SearchTextAndImageEvent({required this.params});
}

class GenerateContentEvent extends SearchEvent {
  final Map<String, dynamic> params;
  GenerateContentEvent({required this.params});
}

class AddMultipleImageEvent extends SearchEvent {
  final NoParams noParams;

  AddMultipleImageEvent({required this.noParams});
}

class ChatEvent extends SearchEvent {
  final Map<String, dynamic> params;
  ChatEvent({required this.params});
}

class GenerateStreamEvent extends SearchEvent {
  final Map<String, dynamic> params;
  GenerateStreamEvent({required this.params});
}

class GenerateStreamStopEvent extends SearchEvent{}

class ReadSQLDataEvent extends SearchEvent{}

class ReadDataDetailsEvent extends SearchEvent{
   final Map<String, dynamic> params;
  ReadDataDetailsEvent({required this.params});
}

class IsSpeechTextEnabledEvent extends SearchEvent{
  
  IsSpeechTextEnabledEvent();
}

class ListenSpeechTextEvent extends SearchEvent{
  
  ListenSpeechTextEvent();
}

class StopSpeechTextEvent extends SearchEvent{
  
  StopSpeechTextEvent();
}
class OnSpeechResultEvent extends SearchEvent{
  
  OnSpeechResultEvent();
}