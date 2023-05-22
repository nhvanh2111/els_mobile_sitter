import 'package:elssit/core/models/education_models/education_all_data_model.dart';

class EducationAllModel {
  EducationAllModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<EducationAllDataModel> data;

  factory EducationAllModel.fromJson(Map<String, dynamic> json) =>
      EducationAllModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: List<EducationAllDataModel>.from(
            json["data"].map((x) => EducationAllDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
