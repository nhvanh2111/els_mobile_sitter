import 'package:elssit/core/models/report_models/report_all_data_model.dart';

class ReportAllModel {
  ReportAllModel({
    required this.successCode,
    required this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<ReportAllDataModel> data;

  factory ReportAllModel.fromJson(Map<String, dynamic> json) => ReportAllModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: List<ReportAllDataModel>.from(
            json["data"].map((x) => ReportAllDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
