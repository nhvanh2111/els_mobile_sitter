import 'package:elssit/core/models/rating_model/rating_data_model.dart';

class RatingModel {
  RatingModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  RatingDataModel data;

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: RatingDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": data.toJson(),
  };
}