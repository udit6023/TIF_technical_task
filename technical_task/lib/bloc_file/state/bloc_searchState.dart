//seach state
import 'package:equatable/equatable.dart';
import 'package:technical_task/modals/allEvents.dart';

import '../../modals/searchEvents.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class Initial extends SearchState {}

class Loading extends SearchState {}

class Loaded extends SearchState {
  final allEvents searcheventModel;
  const Loaded(this.searcheventModel);
}

class Error extends SearchState {
  final String? message;
  const Error(this.message);
}