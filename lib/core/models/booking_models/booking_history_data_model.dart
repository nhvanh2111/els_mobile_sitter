import 'package:elssit/core/models/booking_models/cus_dto.dart';

import 'elder_dto.dart';

class BookingHistoryDataModel {
  BookingHistoryDataModel({
    required this.id,
    required this.address,
    required this.createDate,
    required this.status,
    required this.elderDto,
    required this.totalPrice,
    required this.customerDto,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    this.latitude=0,
    this.longitude=0
  });

  String id;
  String address;
  DateTime createDate;
  String status;
  ElderDto elderDto;
  double totalPrice;
  CustomerDto customerDto;
  DateTime startDate;
  DateTime endDate;
  String startTime;
  double latitude;
  double longitude;

  factory BookingHistoryDataModel.fromJson(Map<String, dynamic> json) =>
      BookingHistoryDataModel(
        id: json["id"],
        address: json["address"],
        createDate: DateTime.parse(json["createDate"]),
        status: json["status"],
        elderDto: ElderDto.fromJson(json["elderDTO"]),
        totalPrice: json["totalPrice"],
        customerDto: CustomerDto.fromJson(json["customerDTO"]),
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        startTime: (json["startTime"] != null) ? json["startTime"] : "",
        latitude:(json["latitude"]!=null)?json["latitude"].toDouble():0,
        longitude:(json["longitude"]!=null)?json["longitude"].toDouble():0
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "createDate":
            "${createDate.year.toString().padLeft(4, '0')}-${createDate.month.toString().padLeft(2, '0')}-${createDate.day.toString().padLeft(2, '0')}",
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "status": status,
        "elderDTO": elderDto,
        "totalPrice": totalPrice,
        "latitude":latitude,
        "longitude":longitude
      };
}
