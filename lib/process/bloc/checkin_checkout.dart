import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:elssit/core/utils/my_utils.dart';
import 'package:elssit/presentation/bottom_bar_navigation/bottom_bar_navigation.dart';
import 'package:elssit/process/event/checkin_checkout_event.dart';
import 'package:elssit/process/state/checkin_checkout_state.dart';
import 'package:flutter/Material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import '../../core/utils/globals.dart' as globals;

class CheckinCheckOutBloc {
  final eventController = StreamController<CheckinCheckoutEvent>();

  final stateController = StreamController<CheckinCheckoutState>();

  final Map<String, String> errors = HashMap();

  String? startDateTime;
  String? endDateTime;
  String? location;
  double lat = 0;
  double lng = 0;

  CheckinCheckOutBloc() {
    eventController.stream.listen((event) async {
      if (event is GetStartDateTimeCheckinCheckoutEvent) {
        startDateTime = event.startDateTime;
        stateController.sink.add(StartDateTimeCheckinCheckoutState(
            dateStartController: TextEditingController(
                text: MyUtils().convertInputDate(event.startDateTime))));
      }
      if (event is GetEndDateTimeCheckinCheckoutEvent) {
        endDateTime = event.endDateTime;
        stateController.sink.add(EndDateTimeCheckinCheckoutState(
            dateEndController: TextEditingController(
                text: MyUtils().convertInputDate(event.endDateTime))));
      }
      if (event is SaveCheckInEvent) {
        print("failBloc -${event.lat},${event.lng}");
        double checkDistance = GeolocatorPlatform.instance
            .distanceBetween(event.lat, event.lng, lat, lng);
        if (checkDistance > 500) {
          Navigator.pop(event.context);
          await QuickAlert.show(
              title: "Vị trí",
              text: "Bạn ở quá xa nơi làm việc",
              context: event.context,
              type: QuickAlertType.warning,
              showCancelBtn: false);
        } else {
          saveCheckin(event.context, event.bookingID, event.startDateTime,
              event.location);
        }
      }
      if (event is SaveCheckOutEvent) {
        print("okhaha");
            Navigator.pop(event.context);
        await saveCheckout(
            event.context, event.bookingID, event.endDateTime, event.location);
      }
    });
  }

  Future<void> saveCheckin(BuildContext context, String bookingID,
      String startDateTime, String location) async {
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
            "startDateTime": startDateTime,
            "location": location,
          },
        ),
      );
      print('Test status code saveCheckin: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => BottomBarNavigation(selectedIndex: 1, isBottomNav: true),), (route) => false);
      } else {
        // ignore: avoid_print
        print(json.decode(response.body)["message"].toString());
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
      print('Test status code saveCheckout: ${response.body}');
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, '/scheduleScreen', (route) => false);
      } else {
        // ignore: avoid_print
      }
    } finally {}
  }
}
