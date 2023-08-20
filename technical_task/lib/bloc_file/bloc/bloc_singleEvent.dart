import 'package:flutter_bloc/flutter_bloc.dart';


import '../../resources/api_resources.dart';
import '../event/bloc_singleEvent.dart';
import '../state/bloc_singleState.dart';

class SingleEventBloc extends Bloc<SingleEvent, SingleState> {
  int? param;
  SingleEventBloc(
    this.param,
  ) : super(Initial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetSingleEventList>((event, emit) async {
      try {
        emit(Loading());
        final mList = await _apiRepository.fetchSingleEventList(param);
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