import 'package:equatable/equatable.dart';
import 'package:technical_task/modals/singleEvent.dart';

abstract class SingleState extends Equatable {
  const SingleState();

  @override
  List<Object?> get props => [];
}

class Initial extends SingleState {}

class Loading extends SingleState {}

class Loaded extends SingleState {
  final SingleEventModal eventModel;
  const Loaded(this.eventModel);
}

class Error extends SingleState {
  final String? message;
  const Error(this.message);
}
