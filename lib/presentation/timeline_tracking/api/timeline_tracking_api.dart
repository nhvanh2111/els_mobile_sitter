import 'dart:convert';
import 'dart:developer';

import 'package:elssit/presentation/timeline_tracking/model/timeline_model.dart';
import 'package:http/http.dart' as http;
import '../../../core/utils/globals.dart' as globals;

class TimelineTrackingApi {
  static Future<List<TimelineModel>> fetchDataTimeLine(String idBooking) async {
// https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/tracking/mobile/get-all-tracking/
    try {
      List<TimelineModel> listRs = [];
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/tracking/mobile/get-all-tracking/${idBooking}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      var dataRespone = jsonDecode(response.body);
      if (response.statusCode.toString() == '200') {
        Iterable listData = dataRespone["data"];

        final mapData = listData.cast<Map<String, dynamic>>();
        listRs = mapData.map<TimelineModel>((json) {
          return TimelineModel.fromJson(json);
        }).toList();
        return listRs;
      }
      if (response.statusCode.toString() == '400') {
        throw Exception(dataRespone["message"]);
      } else {
        throw Exception('Unable to fetch slot from the REST API');
      }
    } finally {}
  }

  static Future<String> logCheckInCheckout(String idBooking) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/check-date-check-in-out/${idBooking}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
    log("logCheckInCheckout" + response.body.toString());
      if (response.statusCode.toString() == '200') {
        return jsonDecode(response.body)["data"];
        // stateController.sink.add(GetAllHistoryByStatusBookingState(
        //     bookingHistoryList:
        //         BookingHistoryModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch test from the REST API');
      }
    } finally {}
  }
}
