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
