import 'package:elssit/core/utils/image_constant.dart';

class CustomerDto {
  CustomerDto({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.address,
    required this.gender,
    required this.status,
    required this.image,
    required this.age,
  });

  String id;
  String fullName;
  String phone;
  String email;
  String address;
  String gender;
  String status;
  String image;
  int age;
  factory CustomerDto.fromJson(Map<String, dynamic> json) => CustomerDto(
    id: json["id"],
    fullName: json["fullName"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    gender: json["gender"],
    status: json["status"],
    image: (json["image"] != null && json["image"]!.toString().isNotEmpty) ? json['image'] : ImageConstant.defaultAva,
    age: (json["age"] != null) ? json["age"] : 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "phone": phone,
    "email": email,
    "address": address,
    "gender": gender,
    "status": status,
    "image" : image,
  };
}