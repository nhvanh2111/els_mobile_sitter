import 'package:elssit/core/models/working_time_model/slot_data_model.dart';

class SlotModel {
  SlotModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<SlotDataModel> data;

  factory SlotModel.fromJson(Map<String, dynamic> json) => SlotModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: List<SlotDataModel>.from(json["data"].map((x) => SlotDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}