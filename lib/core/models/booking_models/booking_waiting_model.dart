import 'package:elssit/core/models/booking_models/booking_waiting_data_model.dart';

class BookingWaitingAllModel {
  BookingWaitingAllModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<BookingWaitingDataModel> data;

  factory BookingWaitingAllModel.fromJson(Map<String, dynamic> json) =>
      BookingWaitingAllModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: List<BookingWaitingDataModel>.from(
            json["data"].map((x) => BookingWaitingDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
