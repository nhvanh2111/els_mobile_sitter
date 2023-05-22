

import 'package:elssit/core/models/schedule_models/schedule_item_data_model.dart';

class ScheduleItemModel {
  ScheduleItemModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<ScheduleItemDataModel> data;

  factory ScheduleItemModel.fromJson(Map<String, dynamic> json) => ScheduleItemModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: List<ScheduleItemDataModel>.from(json["data"].map((x) => ScheduleItemDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}