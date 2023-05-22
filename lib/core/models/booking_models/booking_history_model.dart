import 'package:elssit/core/models/booking_models/booking_history_data_model.dart';

class BookingHistoryModel {
  BookingHistoryModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<BookingHistoryDataModel> data;

  factory BookingHistoryModel.fromJson(Map<String, dynamic> json) =>
      BookingHistoryModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: List<BookingHistoryDataModel>.from(
            json["data"].map((x) => BookingHistoryDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
