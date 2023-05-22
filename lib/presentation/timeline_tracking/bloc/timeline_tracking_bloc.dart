import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:elssit/core/models/booking_models/booking_history_data_model.dart';
import 'package:elssit/core/utils/my_utils.dart';
import 'package:elssit/presentation/timeline_tracking/api/timeline_tracking_api.dart';
import 'package:elssit/presentation/timeline_tracking/bloc/timeline_tracking_event.dart';
import 'package:elssit/presentation/timeline_tracking/bloc/timeline_tracking_state.dart';
import 'package:elssit/presentation/timeline_tracking/model/timeline_model.dart';
import 'package:elssit/presentation/widget/dialog/fail_dialog.dart';
import 'package:elssit/presentation/widget/dialog/success_dialog.dart';
import 'package:flutter/Material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import '../../../core/utils/globals.dart' as globals;

class TimelineBloc {
  final eventController = StreamController<TimeLineEvent>();
  final stateController = StreamController<TimeLineState>();
  String idBooking = "";
  String errorMessage = "";
  List<TimelineModel> listTimeLine = [];
  String statusCheckIn = "NONE";
  late BookingHistoryDataModel modelBooking;
  TimeLineEvent? timeLineEvent;
  double lat = 0;
  double lng = 0;
  bool isLoading = false;
  TimelineBloc() {
    eventController.stream.listen((event) async {
      if (event is OtherTimelineEvent) {
        stateController.sink.add(OtherTimelineState());
      }
      if (event is FetchTimelineEvent) {
        try {
          listTimeLine = await TimelineTrackingApi.fetchDataTimeLine(idBooking);
          statusCheckIn =
              await TimelineTrackingApi.logCheckInCheckout(idBooking);
          stateController.sink.add(OtherTimelineState());
        } catch (e) {
          Navigator.pop(event.context);
          await showFailDialog(
              event.context,
              e.toString().contains(":")
                  ? e.toString().split(":")[1]
                  : e.toString());
        }
      }
      if (event is SaveCheckInTimeLineEvent) {
        try {
        stateController.sink.add(OtherTimelineState(isLoading: true));
          double checkDistance = GeolocatorPlatform.instance.distanceBetween(
              event.position.latitude, event.position.longitude, lat, lng);
          if (checkDistance < 500) {
            await QuickAlert.show(
                title: "Vị trí",
                text: "Bạn ở quá xa nơi làm việc",
                context: event.context,
                type: QuickAlertType.warning,
                showCancelBtn: false);
          } else {
            await saveCheckin(event.context, event.idBooking,
                "${event.position.latitude},${event.position.longitude}");
          }
        } catch (e) {
          await showFailDialog(
              event.context,
              e.toString().contains(":")
                  ? e.toString().split(":")[1]
                  : e.toString());
        }
        stateController.sink.add(OtherTimelineState());
      }
      if (event is SaveCheckOutTimeLineEvent) {
        stateController.sink.add(OtherTimelineState(isLoading: true));
        try {
          await saveCheckout(
              event.context,
              modelBooking.id,
              MyUtils().convertDateToStringInput(DateTime.now()),
              modelBooking.address);
        } catch (e) {
          await showFailDialog(
              event.context,
              e.toString().contains(":")
                  ? e.toString().split(":")[1]
                  : e.toString());
        }
        stateController.sink.add(OtherTimelineState());
      }
    });
  }
  Future<void> saveCheckin(
      BuildContext context, String bookingID, String location) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/check-in");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "bookingId": bookingID,
            "location": location,
          },
        ),
      );
      log('Test status code saveCheckin: ${response.body}');
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        await showSuccessDialog(context, "Bắt đầu làm việc thành công", "/homeScreen");
      } else {
        // ignore: avoid_print
        throw Exception(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> saveCheckout(BuildContext context, String bookingID,
      String endDateTime, String location) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/check-out");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "bookingId": bookingID,
            "endDateTime": endDateTime,
          },
        ),
      );
      print('Test status code saveCheckout: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        await showSuccessDialog(context, "Kết thúc làm việc thành công", "/homeScreen");
      } else {
        // ignore: avoid_print  print();
        throw Exception(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
}
