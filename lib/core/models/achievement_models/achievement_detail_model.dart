import 'package:elssit/core/models/achievement_models/achievement_detail_data_model.dart';

class AchievementDetailModel {
  AchievementDetailModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  AchievementDetailDataModel data;

  factory AchievementDetailModel.fromJson(Map<String, dynamic> json) =>
      AchievementDetailModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: AchievementDetailDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": data.toJson(),
      };
}
