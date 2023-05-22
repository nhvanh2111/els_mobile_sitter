import 'package:elssit/core/models/package_service_models/package_service_detail_data_model.dart';

class PackageServiceDetailModel {
  PackageServiceDetailModel({
    required this.successCode,
    required this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  PackageServiceDetailDataModel data;

  factory PackageServiceDetailModel.fromJson(Map<String, dynamic> json) =>
      PackageServiceDetailModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: PackageServiceDetailDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": data.toJson(),
      };
}
