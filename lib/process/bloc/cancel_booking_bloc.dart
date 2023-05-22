import 'dart:async';
import 'dart:convert';

import 'package:elssit/presentation/widget/dialog/success_dialog.dart';
import 'package:elssit/process/event/cancel_booking_event.dart';
import 'package:elssit/process/state/cancel_booking_state.dart';
import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import '../../core/utils/globals.dart' as globals;
//import '../../presentation/success_screen/success_screen.dart';
import '../../presentation/widget/dialog/fail_dialog.dart';

class CancelBookingBloc {
  final eventController = StreamController<CancelBookingEvent>();
  final stateController = StreamController<CancelBookingState>();
  String title = "";
  String content = "";
  CancelBookingBloc() {
    eventController.stream.listen((event) {
      if (event is ChooseTitleCancelBookingEvent) {
        title = event.title;
      }
      if (event is OtherCancelBookingEvent) {
        stateController.sink.add(OtherCancelBookingState());
      }
      if (event is ChooseInfoBookingContentCancelBookingEvent) {
        content = event.content;
        stateController.sink.add(ChooseInfoBookingCancelBookingState(
            infoBookingType: event.infoBookingType));
      }
      if (event is ChooseTyeCancelBookingEvent) {
        content = event.content;
        stateController.sink.add(ChooseTypeCancelBookingState(
            cancelBookingType: event.cancelBookingType));
      }
      if (event is FillContentCancelBookingEvent) {
        content = event.content;
      }
      if (event is ConfirmCancelBookingEvent) {
        cancelBooking(event.context, event.bookingID);
      }
    });
  }
  Future<void> cancelBooking(BuildContext context, String bookingID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/sitter-cancel-booking");
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
            "reason": "$title - $content"
          },
        ),
      );
      print('Test cancel bookig status:${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        showSuccessDialog(context, "Hủy lịch thành công", "/requestScreen");
      } else {
        // ignore: use_build_context_synchronously
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
}
