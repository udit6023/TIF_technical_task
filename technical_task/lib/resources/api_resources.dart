import 'package:flutter/cupertino.dart';
import 'package:technical_task/modals/allEvents.dart';
import 'package:technical_task/modals/searchEvents.dart';
import 'package:technical_task/modals/singleEvent.dart';

import 'api_func.dart';

class ApiRepository {
  final _provider = APIFUNC();

  Future<allEvents> fetchEventList() {
    return _provider.fetchEventList();
  }

  Future<SingleEventModal> fetchSingleEventList(int? param) {
    return _provider.fetchSingleEvent(param);
  }

  Future<allEvents> fetchSearchEventList(String? para) {
    return _provider.fetchSearchEventList(para);
  }


}

class NetworkError extends Error {}







