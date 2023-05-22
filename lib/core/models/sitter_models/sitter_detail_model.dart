import 'package:elssit/core/models/sitter_models/sitter_detail_data_model.dart';

class SitDetailModel {
  SitDetailModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  SitDetailDataModel data;

  factory SitDetailModel.fromJson(Map<String, dynamic> json) => SitDetailModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: SitDetailDataModel.fromJson(json["data"]),
      );
  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": data.toJson(),
      };
}
