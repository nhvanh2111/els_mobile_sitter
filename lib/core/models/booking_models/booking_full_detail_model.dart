

import 'booking_full_detail_data_model.dart';

class BookingFullDetailModel {
  BookingFullDetailModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  BookingFullDetailDataModel data;

  factory BookingFullDetailModel.fromJson(Map<String, dynamic> json) => BookingFullDetailModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: BookingFullDetailDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": data.toJson(),
  };
}