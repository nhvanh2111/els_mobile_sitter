import 'dart:async';
import 'dart:convert';

import 'package:elssit/core/models/report_models/report_all_model.dart';
import 'package:elssit/presentation/widget/dialog/success_dialog.dart';
import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import '../../core/utils/globals.dart' as globals;
import '../../presentation/widget/dialog/fail_dialog.dart';
import '../event/report_event.dart';
import '../state/report_state.dart';

class ReportBloc {
  final eventController = StreamController<ReportEvent>();
  final stateController = StreamController<ReportState>();
  String? title;
  String? content;
  ReportBloc() {
    eventController.stream.listen((event) {
      if (event is ChooseTitleReportEvent) {
        title = event.title;
      }
      if (event is OtherReportEvent) {
        stateController.sink.add(OtherReportState());
      }
      if (event is ChooseAttitudeContentReportEvent) {
        content = event.content;
        stateController.sink.add(
            ChooseAttitudeContentReportState(attitudeType: event.attitudeType));
      }
      if (event is ChooseCusInfoContentReportEvent) {
        content = event.content;
        stateController.sink.add(
            ChooseCusInfoContentReportState(cusInfoType: event.cusInfoType));
      }
      if (event is FillContentReportEvent) {
        content = event.content;
      }
      if (event is ConfirmReportEvent) {
        report(event.context, event.bookingDetailID, event.customerID);
      }
      if (event is GetAllReportEvent) {
        getAllReport();
      }
    });
  }

  Future<void> report(
      BuildContext context, String bookingDetailID, String customerID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/report/mobile/sitter-to-customer");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "bookingDetailId": bookingDetailID,
            "title": title,
            "content": content,
            "sitterId": globals.sitterID,
            "customerId": customerID,
          },
        ),
      );
      print('Test report status:${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        showSuccessDialog(context, "Phản Hồi thành công", "/scheduleScreen");
      } else {
        // ignore: use_build_context_synchronously
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> getAllReport() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/report/mobile/get-all-for-sitter/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllReportState(
            reportList: ReportAllModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch  from the REST API');
      }
    } finally {}
  }
}
