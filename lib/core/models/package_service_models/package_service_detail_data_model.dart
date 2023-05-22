import 'package:elssit/core/models/package_service_models/service_dto.dart';

class PackageServiceDetailDataModel {
  PackageServiceDetailDataModel({
    required this.id,
    required this.name,
    required this.img,
    required this.duration,
    required this.price,
    required this.healthStatus,
    required this.desc,
    required this.serviceDtos,
  });

  String id;
  String name;
  String img;
  int duration;
  double price;
  dynamic healthStatus;
  String desc;
  List<ServiceDto> serviceDtos;

  factory PackageServiceDetailDataModel.fromJson(Map<String, dynamic> json) =>
      PackageServiceDetailDataModel(
        id: json["id"],
        name: (json["name"] != null) ? json["name"] : "",
        img: (json["img"] != null) ? json["img"] : "",
        duration: (json["duration"] != null) ? json["duration"] : "",
        price: (json["price"] != null) ? json["price"] : "",
        healthStatus:
            (json["healthStatus"] != null) ? json["healthStatus"] : "",
        desc: (json["desc"] != null) ? json["desc"] : "",
        serviceDtos: List<ServiceDto>.from(
            json["serviceDTOS"].map((x) => ServiceDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "duration": duration,
        "price": price,
        "healthStatus": healthStatus,
        "desc": desc,
        "serviceDTOS": List<dynamic>.from(serviceDtos.map((x) => x.toJson())),
      };
}
