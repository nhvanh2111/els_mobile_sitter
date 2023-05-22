import 'package:elssit/core/models/working_time_model/working_time_data_model.dart';

class WorkingTimeModel {
  WorkingTimeModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<WorkingTimeDataModel> data;

  factory WorkingTimeModel.fromJson(Map<String, dynamic> json) => WorkingTimeModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: List<WorkingTimeDataModel>.from(json["data"].map((x) => WorkingTimeDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}