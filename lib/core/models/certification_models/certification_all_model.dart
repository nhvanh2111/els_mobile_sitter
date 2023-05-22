import 'certification_all_data_model.dart';

class CertificationAllModel {
  CertificationAllModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<CertificationAllDataModel> data;

  factory CertificationAllModel.fromJson(Map<String, dynamic> json) =>
      CertificationAllModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: List<CertificationAllDataModel>.from(
            json["data"].map((x) => CertificationAllDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
