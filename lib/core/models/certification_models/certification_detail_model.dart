import 'package:elssit/core/models/certification_models/certification_detail_data_model.dart';

class CertificationDetailModel {
  CertificationDetailModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  CertificationDetailDataModel data;

  factory CertificationDetailModel.fromJson(Map<String, dynamic> json) =>
      CertificationDetailModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: CertificationDetailDataModel.fromJson(json["data"]),
      );
  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": data.toJson(),
      };
}
