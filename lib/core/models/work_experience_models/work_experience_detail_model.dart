import 'package:elssit/core/models/work_experience_models/work_experience_detail_data_model.dart';

class WorkExperienceDetailModel {
  WorkExperienceDetailModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  WorkExperienceDetailDataModel data;

  factory WorkExperienceDetailModel.fromJson(Map<String, dynamic> json) =>
      WorkExperienceDetailModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: WorkExperienceDetailDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": data.toJson(),
      };
}
