import 'dart:async';
import 'dart:convert';

import 'package:elssit/core/models/schedule_models/schedule_item_data_model.dart';
import 'package:http/http.dart' as http;
import '../../core/models/schedule_models/schedue_item_model.dart';
import '../../core/utils/globals.dart' as globals;
import '../event/schedule_event.dart';
import '../state/schedule_state.dart';

class ScheduleBloc {
  final eventController = StreamController<ScheduleEvent>();
  final stateController = StreamController<ScheduleState>();

  ScheduleBloc() {
    eventController.stream.listen((event) async {
      if (event is GetListItemScheduleEvent) {
        stateController.sink.add(LoadingState());
        List<ScheduleItemDataModel> listSchedule = await getListScheduleItem();
        if (listSchedule.isNotEmpty) {
          stateController.sink.add(HaveDataState(listSchedule: listSchedule));
        } else {
          stateController.sink.add(NotHaveDataState());
        }
      }
      if (event is OtherScheduleEvent) {
        stateController.sink.add(OtherScheduleState());
      }
    });
  }

  Future<List<ScheduleItemDataModel>> getListScheduleItem() async {
    try {
      List<ScheduleItemDataModel> listRs = [];
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/booking/mobile/get-schedule-sitter/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );

      //print('test getListScheduleItem status code: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        var dataRespone = jsonDecode(response.body);
        Iterable listData = dataRespone["data"];
        final mapData = listData.cast<Map<String, dynamic>>();
        listRs = mapData.map<ScheduleItemDataModel>((json) {
          return ScheduleItemDataModel.fromJson(json);
        }).toList();
        return listRs;
      } else {
        throw Exception('Unable to fetch Schedule from the REST API');
      }
    } finally {}
  }
}
