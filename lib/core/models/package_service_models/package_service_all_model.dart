import 'package:elssit/core/models/package_service_models/package_service_all_data_model.dart';

class PackageServiceAllModel {
  PackageServiceAllModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<PackageServiceAllDataModel> data;

  factory PackageServiceAllModel.fromJson(Map<String, dynamic> json) =>
      PackageServiceAllModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: List<PackageServiceAllDataModel>.from(
            json["data"].map((x) => PackageServiceAllDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
