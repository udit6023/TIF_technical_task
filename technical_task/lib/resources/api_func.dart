import 'package:dio/dio.dart';

import 'package:technical_task/modals/allEvents.dart';
import 'package:technical_task/modals/singleEvent.dart';



class APIFUNC {
 
  

  Future<allEvents> fetchEventList() async {
     final Dio _dio = Dio();
    final String _url = 'https://sde-007.api.assignment.theinternetfolks.works/v1/event';
    try {
      Response response = await _dio.get(_url);
      return allEvents.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return allEvents.withError("Data not found / Connection issue");
    }
  }


  Future<allEvents> fetchSearchEventList(String? para) async {
     final Dio _dio = Dio();
    final String _url = 'https://sde-007.api.assignment.theinternetfolks.works/v1/event?search=$para';
    try {
      Response response = await _dio.get(_url);
      return allEvents.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return allEvents.withError("Data not found / Connection issue");
    }
  }


   Future<SingleEventModal> fetchSingleEvent(int? id) async {
     final Dio _dio = Dio();
    final String _url = 'https://sde-007.api.assignment.theinternetfolks.works/v1/event/+$id';
    try {
      Response response = await _dio.get(_url);
      return SingleEventModal.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return SingleEventModal.withError("Data not found / Connection issue");
    }
  }


}

