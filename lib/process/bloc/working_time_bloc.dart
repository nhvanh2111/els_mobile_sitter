// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:elssit/core/models/working_time_model/working_time_model.dart';
import 'package:elssit/presentation/widget/dialog/success_dialog.dart';
import 'package:elssit/process/event/working_time_event.dart';
import 'package:elssit/process/state/working_time_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../core/utils/globals.dart' as globals;
import '../../presentation/widget/dialog/fail_dialog.dart';

class WorkingTimeBloc {
  final eventController = StreamController<WorkingTimeEvent>();
  final stateController = StreamController<WorkingTimeState>();

  String listWeek = "";

  Map<String, List<String>> mapWeek = HashMap();
  bool isSetSlotForAll = false;
  List<String> listSlotForAll = [];

  WorkingTimeBloc() {
    eventController.stream.listen((event) {
      if (event is OtherWorkingTimeEvent) {
        stateController.sink.add(OtherWorkingTimeState());
      }

      if (event is ConfirmWorkingTimeEvent) {
        if (isSetSlotForAll) {
          mapWeek.forEach((key, value) {
            for (var element in listSlotForAll) {
              mapWeek[key]?.add(element);
            }
          });
        }
        listWeek = "";
        if (mapWeek.containsKey("MONDAY")) {
          List<String> listSlot = mapWeek["MONDAY"]!;
          listSlot.sort(
            (a, b) {
              if (int.parse(a) > int.parse(b)) {
                return 1;
              } else {
                return -1;
              }
            },
          );
          for (String s in listSlot) {
            if (listWeek.isEmpty) {
              listWeek = "MONDAY $s";
            } else {
              if (s == listSlot[listSlot.length - 1]) {
                listWeek = "$listWeek-$s;";
              } else {
                listWeek = "$listWeek-$s";
              }
            }
          }
        }
        if (mapWeek.containsKey("TUESDAY")) {
          List<String> listSlot = mapWeek["TUESDAY"]!;
          listSlot.sort(
            (a, b) {
              if (int.parse(a) > int.parse(b)) {
                return 1;
              } else {
                return -1;
              }
            },
          );
          for (String s in listSlot) {
            if (listWeek.isEmpty || listWeek[listWeek.length - 1] == ";") {
              listWeek = "${listWeek}TUESDAY $s";
            } else {
              if (s == listSlot[listSlot.length - 1]) {
                listWeek = "$listWeek-$s;";
              } else {
                listWeek = "$listWeek-$s";
              }
            }
          }
        }
        if (mapWeek.containsKey("WEDNESDAY")) {
          List<String> listSlot = mapWeek["WEDNESDAY"]!;
          listSlot.sort(
            (a, b) {
              if (int.parse(a) > int.parse(b)) {
                return 1;
              } else {
                return -1;
              }
            },
          );
          for (String s in listSlot) {
            if (listWeek.isEmpty || listWeek[listWeek.length - 1] == ";") {
              listWeek = "${listWeek}WEDNESDAY $s";
            } else {
              if (s == listSlot[listSlot.length - 1]) {
                listWeek = "$listWeek-$s;";
              } else {
                listWeek = "$listWeek-$s";
              }
            }
          }
        }
        if (mapWeek.containsKey("THURSDAY")) {
          List<String> listSlot = mapWeek["THURSDAY"]!;
          listSlot.sort(
            (a, b) {
              if (int.parse(a) > int.parse(b)) {
                return 1;
              } else {
                return -1;
              }
            },
          );
          for (String s in listSlot) {
            if (listWeek.isEmpty || listWeek[listWeek.length - 1] == ";") {
              listWeek = "${listWeek}THURSDAY $s";
            } else {
              if (s == listSlot[listSlot.length - 1]) {
                listWeek = "$listWeek-$s;";
              } else {
                listWeek = "$listWeek-$s";
              }
            }
          }
        }
        if (mapWeek.containsKey("FRIDAY")) {
          List<String> listSlot = mapWeek["FRIDAY"]!;
          listSlot.sort(
            (a, b) {
              if (int.parse(a) > int.parse(b)) {
                return 1;
              } else {
                return -1;
              }
            },
          );
          for (String s in listSlot) {
            if (listWeek.isEmpty || listWeek[listWeek.length - 1] == ";") {
              listWeek = "${listWeek}FRIDAY $s";
            } else {
              if (s == listSlot[listSlot.length - 1]) {
                listWeek = "$listWeek-$s;";
              } else {
                listWeek = "$listWeek-$s";
              }
            }
          }
        }
        if (mapWeek.containsKey("SATURDAY")) {
          List<String> listSlot = mapWeek["SATURDAY"]!;
          listSlot.sort(
            (a, b) {
              if (int.parse(a) > int.parse(b)) {
                return 1;
              } else {
                return -1;
              }
            },
          );
          for (String s in listSlot) {
            if (listWeek.isEmpty || listWeek[listWeek.length - 1] == ";") {
              listWeek = "${listWeek}SATURDAY $s";
            } else {
              if (s == listSlot[listSlot.length - 1]) {
                listWeek = "$listWeek-$s;";
              } else {
                listWeek = "$listWeek-$s";
              }
            }
          }
        }
        if (mapWeek.containsKey("SUNDAY")) {
          List<String> listSlot = mapWeek["SUNDAY"]!;
          listSlot.sort(
            (a, b) {
              if (int.parse(a) > int.parse(b)) {
                return 1;
              } else {
                return -1;
              }
            },
          );
          for (String s in listSlot) {
            if (listWeek.isEmpty || listWeek[listWeek.length - 1] == ";") {
              listWeek = "${listWeek}SUNDAY $s";
            } else {
              if (s == listSlot[listSlot.length - 1]) {
                listWeek = "$listWeek-$s;";
              } else {
                listWeek = "$listWeek-$s";
              }
            }
          }
        }
        updateWorkingTimeWeek(
            event.context, listWeek.substring(0, listWeek.length - 1));
      }
      if (event is ChooseDateInWeekWorkingTimeEvent) {
        if (mapWeek.isEmpty) {
          mapWeek.addAll({event.date: []});
        } else {
          if (mapWeek.containsKey(event.date)) {
            mapWeek.remove(event.date);
          } else {
            mapWeek.addAll({event.date: []});
          }
        }
        stateController.sink
            .add(ChooseDateInWeekWorkingTimeState(mapWeek: mapWeek));
      }
      if (event is ChooseSlotForDateInWeekWorkingTimeEvent) {
        if (mapWeek[event.date]!.isEmpty) {
          mapWeek[event.date]!.add(event.slot);
        } else {
          if (mapWeek[event.date]!.contains(event.slot)) {
            mapWeek[event.date]!.remove(event.slot);
          } else {
            mapWeek[event.date]!.add(event.slot);
          }
        }
        stateController.sink
            .add(ChooseDateInWeekWorkingTimeState(mapWeek: mapWeek));
      }
      if (event is SetChosenDateInWeekTimeEvent) {
        stateController.sink.add(SetChosenDateInWeekTimeState(
            chosenDateInWeek: event.chosenDateInWeek));
      }
      if (event is GetAllWorkingTimeEvent) {
        getAllWorkingTime();
      }
      if (event is SetSlotForAllEvent) {
        Map<String, List<String>> mapWeekTemp = HashMap();
        mapWeek.forEach((key, value) {
          mapWeekTemp.addAll({key: []});
        });
        mapWeek = mapWeekTemp;
        isSetSlotForAll = event.isSetSlotForAll;
        stateController.sink
            .add(SetSlotForAllState(isSetSlotForAll: isSetSlotForAll));
      }
      if (event is ChooseSlotForAllEvent) {
        if (listSlotForAll.isEmpty) {
          listSlotForAll.add(event.slot);
        } else {
          if (listSlotForAll.contains(event.slot)) {
            listSlotForAll.remove(event.slot);
          } else {
            listSlotForAll.add(event.slot);
          }
        }
        stateController.sink
            .add(ChooseSlotForAllState(listSlotForAll: listSlotForAll));
      }
    });
  }

  Future<void> getAllWorkingTime() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/sitter/mobile/get-all-working-time/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        WorkingTimeModel model =
            WorkingTimeModel.fromJson(json.decode(response.body));
        mapWeek.clear();
        for (var element in model.data) {
          if (element.slots != null) {
            mapWeek.addAll({element.dayOfWeek: element.slots!.split("-")});
          }
        }
        stateController.sink.add(GetAllWorkingTimeState(mapWeek: mapWeek));
      } else {
        throw Exception('Unable to fetch slot from the REST API');
      }
    } finally {}
  }

  Future<void> updateWorkingTimeWeek(BuildContext context, String slots) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/sitter/mobile/add-working-time-week");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "sitterId": globals.sitterID,
            "dayOfWeekAndSlots": slots
          },
        ),
      );
      print('Test status Code updateWorkingTimeWeek: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        if (globals.sitterStatus == "CREATED" ||
            globals.sitterStatus == "REJECTED") {
          Navigator.pushNamed(context, '/packageScreen');
        } else {
          showSuccessDialog(context, "Cập nhật thời gian làm việc thành công",
              "/accountScreen");
        }
        if (kDebugMode) {
          print('Thành công');
        }
      } else {
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
}
