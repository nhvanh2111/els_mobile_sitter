import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:elssit/presentation/list_waiting_assign/model/booking_waiting_acept.dart';

import '../../../core/utils/globals.dart' as globals;
import 'package:elssit/presentation/list_waiting_assign/bloc/listwaiting_state.dart';
import 'package:elssit/presentation/list_waiting_assign/bloc/listwaitting_event.dart';
import 'package:elssit/presentation/list_waiting_assign/screen/list_waitting_accept.dart';
import 'package:http/http.dart' as http;

class ListWaittingBloc {
  final stateController = StreamController<ListWaittingState>();
  final eventController = StreamController<ListWaittingEvent>();
  List<BookingWAccept> listData = [];
  ListWaittingBloc() {
    eventController.stream.listen((ListWaittingEvent event) async {
      if (event is OtherListWaitingEvent) {
        stateController.sink.add(OtherListWaitingSate());
      }
      if (event is FetchDataListWaitingEvent) {
        print("ac");
        try {
          listData = await fetchData();

        } catch (e) {
          print("e exception - ${e}" );
          listData = [];
        }
        stateController.sink.add(OtherListWaitingSate());
      }
      if (event is AcceptListWaitingEvent) {
         await confirm(event.idBooking, event.isAcept);
      }
      if (event is DenyListWaitingEvent) {
        await confirm(event.idBooking, event.isAcept);
      }
      //DenyListWaitingEvent
    });
  }

  Future<List<BookingWAccept>> fetchData() async {
    try {
      List<BookingWAccept> rs = [];
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/sitter/mobile/waiting-assigned-booking-list/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      log('test fetchData status code: ${response.body}');
      if (response.statusCode.toString() == '200') {
        var dataRespone = jsonDecode(response.body);
        Iterable listData = dataRespone["data"];
        final mapData = listData.cast<Map<String, dynamic>>();
        rs = mapData.map<BookingWAccept>((json) {
          return BookingWAccept.fromJson(json);
        }).toList();
        log("fetchData"+ rs.length.toString());

        return rs;
      } else {
        return rs = [];
        throw Exception('Unable to fetch Booking from the REST API');
      }
    } finally {}
  }

  Future<void> confirm(String bookingID, bool isAccept) async {
//api/v1/sitter/mobile/accept-booking
    var url = Uri.parse(
        "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/sitter/mobile/accept-booking");
    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "isAccept": isAccept,
          "bookingId": bookingID,
          "sitterId": globals.sitterID
        }));
    if (response.statusCode.toString() == '200') {
    } else {
      throw Exception('Unable to fetch Booking from the REST API');
    }
  }
}
