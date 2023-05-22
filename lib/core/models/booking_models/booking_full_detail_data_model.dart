import 'package:elssit/core/models/booking_models/sitter_dto.dart';

import 'booking_detail_form_dto.dart';
import 'cus_dto.dart';
import 'elder_dto.dart';

class BookingFullDetailDataModel {
  BookingFullDetailDataModel(
      {required this.id,
      required this.address,
      required this.place,
      required this.createDate,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.deposit,
      required this.status,
      required this.totalPrice,
      required this.customerDto,
      required this.elderDto,
      required this.sitterDto,
      required this.bookingDetailFormDtos,
      required this.latitude,
      required this.longitude});

  String id;
  String address;
  String place;
  DateTime createDate;
  DateTime startDate;
  DateTime endDate;
  String startTime;
  String endTime;
  double deposit;
  String status;
  double totalPrice;
  CustomerDto customerDto;
  ElderDto elderDto;
  SitterDto sitterDto;
  List<BookingDetailFormDto> bookingDetailFormDtos;
  double latitude;
  double longitude;

  factory BookingFullDetailDataModel.fromJson(Map<String, dynamic> json) =>
      BookingFullDetailDataModel(
        id: json["id"],
        address: json["address"],
        place: (json["place"] != null) ? json["place"] : "",
        createDate: DateTime.parse(json["createDate"]),
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        deposit: json["deposit"],
        status: json["status"],
        totalPrice: json["totalPrice"],
        customerDto: CustomerDto.fromJson(json["customerDTO"]),
        elderDto: ElderDto.fromJson(json["elderDTO"]),
        sitterDto: SitterDto.fromJson(json["sitterDTO"]),
        bookingDetailFormDtos: List<BookingDetailFormDto>.from(
            json["bookingDetailFormDTOS"]
                .map((x) => BookingDetailFormDto.fromJson(x))),
        latitude:
            (json["latitude"] != null) ? json["latitude"].toDouble() : 0.0,
        longitude:
            (json["longitude"] != null) ? json["longitude"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "place": place,
        "createDate":
            "${createDate.year.toString().padLeft(4, '0')}-${createDate.month.toString().padLeft(2, '0')}-${createDate.day.toString().padLeft(2, '0')}",
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "startTime": startTime,
        "endTime": endTime,
        "deposit": deposit,
        "status": status,
        "totalPrice": totalPrice,
        "customerDTO": customerDto.toJson(),
        "elderDTO": elderDto.toJson(),
        "sitterDTO": sitterDto,
        "bookingDetailFormDTOS":
            List<dynamic>.from(bookingDetailFormDtos.map((x) => x.toJson())),
        "latitude": latitude,
        "longitude": longitude
      };
}
