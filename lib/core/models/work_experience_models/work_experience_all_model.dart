import 'package:elssit/core/models/work_experience_models/work_experience_all_data_model.dart';

class WorkExperienceAllModel {
  WorkExperienceAllModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<WorkExperienceAllDataModel> data;

  factory WorkExperienceAllModel.fromJson(Map<String, dynamic> json) =>
      WorkExperienceAllModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: List<WorkExperienceAllDataModel>.from(
            json["data"].map((x) => WorkExperienceAllDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
