class ServiceDto {
  ServiceDto({
    required this.id,
    required this.name,
    required this.price,
    required this.status,
    this.requirement,
  });

  String id;
  String name;
  double price;
  String status;
  dynamic requirement;

  factory ServiceDto.fromJson(Map<String, dynamic> json) => ServiceDto(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        status: json["status"],
        requirement: json["requirement"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "status": status,
        "requirement": requirement,
      };
}
