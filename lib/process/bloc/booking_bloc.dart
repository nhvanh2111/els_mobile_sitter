import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:elssit/core/models/booking_models/booking_history_model.dart';
import 'package:elssit/core/models/booking_models/booking_waiting_model.dart';
import 'package:elssit/process/bloc/authen_bloc.dart';
import 'package:elssit/process/state/authen_state.dart';
import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/models/booking_models/booking_full_detail_model.dart';
import '../../core/models/test_models/test_schedule_model.dart';
import '../../core/utils/globals.dart' as globals;
import '../../core/validators/validations.dart';
import '../event/booking_event.dart';
import '../state/booking_state.dart';

class BookingBloc {
  final eventController = StreamController<BookingEvent>();

  final stateController = StreamController<BookingState>();
  String statusCheckIn = "NONE";

  BookingBloc() {
    eventController.stream.listen((event) async {
      if (event is TestGetAllBookingEvent) {
        await testGetAll();
      }
      if (event is OtherBookingEvent) {
        stateController.sink.add(OtherBookingState()); //Test schedule event
      }
      if (event is GetFullDetailBookingEvent) {
        await logCheckInCheckout(event.bookingID);
        await getBookingFullDetail(event.bookingID);
// stateController.sink.add(OtherBookingState());
      }
      if (event is GetBookingWatingEvent) {
        await getBookingWaiting();
      }
      if (event is GetAllHistoryBookingEvent) {
        await getAllHistory();
      }
      if (event is GetAllHistoryByStatusBookingEvent) {
        await getAllHistoryByStatus(event.status);
      }
    });
  }

  Future<void> testGetAll() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api-chi-de-test/testCalender");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(TestGetAllBookingState(
            testModel: TestScheduleModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch test from the REST API');
      }
    } finally {}
  }

  Future<void> getBookingFullDetail(String bookingID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/common/get-full-detail-booking/$bookingID");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      //print('test getBookingFullDetail status code: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetFullDetailBookingState(
            booking:
                BookingFullDetailModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch Booking from the REST API');
      }
    } finally {}
  }

  Future<void> getBookingWaiting() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/get-booking-in-present-for-sitter/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {

        stateController.sink.add(GetWaitingBookingState(
            bookingWaitingList:
                BookingHistoryModel.fromJson(json.decode(response.body))));
      } else if (response.statusCode.toString() == '400') {
        throw Exception(jsonDecode(response.body)["message"]);
      } else {
        throw Exception('Unable to fetch test from the REST API');
      }
    } finally {}
  }

  Future<void> getAllHistory() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/get-all-booking-history-by-sitter/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllHistoryBookingState(
            bookingHistoryList:
                BookingHistoryModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch test from the REST API');
      }
    } finally {}
  }

  Future<void> getAllHistoryByStatus(String status) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/get-all-booking-by-status-and-sitter_id/$status/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      log("getAllHistoryByStatus" + response.statusCode.toString());
      log("getAllHistoryByStatus" + response.body.toString());

      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllHistoryByStatusBookingState(
            bookingHistoryList:
                BookingHistoryModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch test from the REST API');
      }
    } finally {}
  }

  Future<void> logCheckInCheckout(String idBooking) async {
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
      print("logCheckInCheckout" + response.body.toString());
      if (response.statusCode.toString() == '200') {
        statusCheckIn = jsonDecode(response.body)["data"];
        // stateController.sink.add(GetAllHistoryByStatusBookingState(
        //     bookingHistoryList:
        //         BookingHistoryModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch test from the REST API');
      }
    } finally {}
  }
}

class GetAllPresentBooking {}
