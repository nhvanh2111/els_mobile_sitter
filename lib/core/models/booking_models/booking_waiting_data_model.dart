import 'package:elssit/core/models/booking_models/elder_dto.dart';

class BookingWaitingDataModel {
  BookingWaitingDataModel({
    required this.id,
    required this.address,
     this.place="",
    required this.createDate,
    required this.status,
    required this.elderDto,
    required this.totalPrice,
  });

  String id;
  String address;
  String? place;
  DateTime createDate;
  String status;
  ElderDto elderDto;
  double totalPrice;

  factory BookingWaitingDataModel.fromJson(Map<String, dynamic> json) =>
      BookingWaitingDataModel(
        id: json["id"],
        address: json["address"],
        place: json["place"],
        createDate: DateTime.parse(json["createDate"]),
        status: json["status"],
        elderDto: ElderDto.fromJson(json["elderDTO"]),
        totalPrice: json["totalPrice"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "place": place,
        "createDate":
            "${createDate.year.toString().padLeft(4, '0')}-${createDate.month.toString().padLeft(2, '0')}-${createDate.day.toString().padLeft(2, '0')}",
        "status": status,
        "elderDTO": elderDto.toJson(),
        "totalPrice": totalPrice,
      };
}
