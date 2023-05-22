class PackageDto {
  PackageDto({
    required this.id,
    required this.name,
    this.img,
    required this.duration,
    required this.price,
    required this.desc,
    this.status,
  });

  String id;
  String name;
  dynamic img;
  int duration;
  double price;
  String desc;
  dynamic status;

  factory PackageDto.fromJson(Map<String, dynamic> json) => PackageDto(
    id: json["id"],
    name: json["name"],
    img: json["img"],
    duration: json["duration"],
    price: json["price"],
    desc: json["desc"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "img": img,
    "duration": duration,
    "price": price,
    "desc": desc,
    "status": status,
  };
}