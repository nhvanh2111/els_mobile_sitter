class SitterDto {
  SitterDto({
    required this.id,
    this.fullName,
    required this.phone,
    required this.email,
    this.address,
    this.gender,
    required this.status,
  });

  String id;
  String? fullName;
  String phone;
  String email;
  String? address;
  String? gender;
  String status;

  factory SitterDto.fromJson(Map<String, dynamic> json) => SitterDto(
    id: json["id"],
    fullName: json["fullName"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    gender: json["gender"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "phone": phone,
    "email": email,
    "address": address,
    "gender": gender,
    "status": status,
  };
}