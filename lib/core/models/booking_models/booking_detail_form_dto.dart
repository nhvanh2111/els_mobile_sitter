

import 'package:elssit/core/models/booking_models/package_dto.dart';

import 'detail_service_dto.dart';

class BookingDetailFormDto {
  BookingDetailFormDto({
    required this.id,
    required this.estimateTime,
    required this.packageName,
    required this.startDateTime,
    required this.endDateTime,
    required this.packageDto,
    required this.detailServiceDtos,
    required this.bookingDetailStatus,
  });

  String id;
  int estimateTime;
  String packageName;
  String startDateTime;
  String endDateTime;
  PackageDto packageDto;
  List<DetailServiceDto> detailServiceDtos;
  String? bookingDetailStatus;

  factory BookingDetailFormDto.fromJson(Map<String, dynamic> json) => BookingDetailFormDto(
    id: json["id"],
    estimateTime: json["estimateTime"],
    packageName: json["packageName"],
    startDateTime: json["startDateTime"],
    endDateTime: json["endDateTime"],
    packageDto: PackageDto.fromJson(json["packageDTO"]),
    detailServiceDtos: List<DetailServiceDto>.from(json["detailServiceDTOS"].map((x) => DetailServiceDto.fromJson(x))),
    bookingDetailStatus: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "estimateTime": estimateTime,
    "packageName": packageName,
    "startDateTime": startDateTime,
    "endDateTime": endDateTime,
    "packageDTO": packageDto.toJson(),
    "detailServiceDTOS": List<dynamic>.from(detailServiceDtos.map((x) => x.toJson())),
  };
}