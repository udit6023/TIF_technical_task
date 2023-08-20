//search event
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/api_resources.dart';
import '../event/bloc_event.dart';
import '../event/bloc_searchEvent.dart';
import '../state/bloc_searchState.dart';



class SearchBloc extends Bloc<SearchEvent, SearchState> {
  String? param;
  SearchBloc(
    this.param,
  ) : super(Initial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetSearchEventList>((event, emit) async {
      try {
        emit(Loading());
        final mList = await _apiRepository.fetchSearchEventList(param);
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