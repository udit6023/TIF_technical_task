// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import '../../resources/api_resources.dart';
import '../event/bloc_event.dart';
import '../state/bloc_state.dart';

class Bloc1 extends Bloc<Event, State1> {
  
  Bloc1() : super(Initial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetEventList>((event, emit) async {
      try {
        emit(Loading());
        final mList = await _apiRepository.fetchEventList();
        emit(Loaded(mList));
        if (mList.error != null) {
          emit(Error(mList.error));
        }
      } on NetworkError {
        emit(Error("Failed to fetch data. is your device online?"));
      }
    });
  }
}



