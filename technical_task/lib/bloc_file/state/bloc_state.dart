import 'package:equatable/equatable.dart';
import 'package:technical_task/modals/allEvents.dart';

import '../../modals/searchEvents.dart';

abstract class State1 extends Equatable {
  const State1();

  @override
  List<Object?> get props => [];
}

class Initial extends State1 {}

class Loading extends State1 {}

class Loaded extends State1 {
  final allEvents eventModel;
  const Loaded(this.eventModel);
}

class Error extends State1 {
  final String? message;
  const Error(this.message);
}



