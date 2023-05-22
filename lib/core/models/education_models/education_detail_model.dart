import 'package:elssit/core/models/education_models/education_detail_data_model.dart';

class EducationDetailModel {
  EducationDetailModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  EducationDetailDataModel data;

  factory EducationDetailModel.fromJson(Map<String, dynamic> json) =>
      EducationDetailModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: EducationDetailDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": data.toJson(),
      };
}
