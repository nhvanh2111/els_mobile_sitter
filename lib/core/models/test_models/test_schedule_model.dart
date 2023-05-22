
import 'package:elssit/core/models/test_models/test_schedule_data_model.dart';

class TestScheduleModel {
  TestScheduleModel({
    this.successCode,
    this.errorCode,
    required this.data,
  });

  dynamic successCode;
  dynamic errorCode;
  List<TestScheduleDataModel> data;

  factory TestScheduleModel.fromJson(Map<String, dynamic> json) => TestScheduleModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: List<TestScheduleDataModel>.from(json["data"].map((x) => TestScheduleDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}