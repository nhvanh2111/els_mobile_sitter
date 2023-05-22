import 'package:elssit/core/models/achievement_models/achievement_all_data_model.dart';

class AchievementAllModel {
  AchievementAllModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<AchievementAllDataModel> data;

  factory AchievementAllModel.fromJson(Map<String, dynamic> json) =>
      AchievementAllModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: List<AchievementAllDataModel>.from(
            json["data"].map((x) => AchievementAllDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
