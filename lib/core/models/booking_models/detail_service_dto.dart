class DetailServiceDto {
  DetailServiceDto({
    required this.id,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceDuration,
  });

  String id;
  String serviceName;
  double servicePrice;
  double serviceDuration;

  factory DetailServiceDto.fromJson(Map<String, dynamic> json) =>
      DetailServiceDto(
        id: json["id"],
        serviceName: json["serviceName"],
        servicePrice: (json["servicePrice"] != null) ? json["servicePrice"] : 0,
        serviceDuration:
            (json["serviceDuration"] != null) ? json["serviceDuration"] : 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serviceName": serviceName,
        "servicePrice": servicePrice,
        "serviceDuration": serviceDuration,
      };
}
