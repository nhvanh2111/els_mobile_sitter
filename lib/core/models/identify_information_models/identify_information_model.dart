import 'package:elssit/core/models/identify_information_models/identify_information_data_model.dart';

class IdentifyInformationModel {
  IdentifyInformationModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  IdentifyInformationDataModel data;

  factory IdentifyInformationModel.fromJson(Map<String, dynamic> json) => IdentifyInformationModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: IdentifyInformationDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": data.toJson(),
  };
}