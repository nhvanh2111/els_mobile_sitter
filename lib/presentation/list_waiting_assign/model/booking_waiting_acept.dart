// To parse this JSON data, do
//
//     final bookingWAccept = bookingWAcceptFromJson(jsonString);

import 'dart:convert';

List<BookingWAccept> bookingWAcceptFromJson(String str) =>
    List<BookingWAccept>.from(
        json.decode(str).map((x) => BookingWAccept.fromJson(x)));

String bookingWAcceptToJson(List<BookingWAccept> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingWAccept {
  BookingWAccept({
    required this.bookingId,
    required this.address,
    required this.startDate,
    required this.slots,
    this.endDate = "",
    this.description = "",
    required this.elder,
    required this.totalPrice,
    required this.apackage,
  });

  String bookingId;
  String address;
  String startDate;
  String slots;
  String endDate;
  String description;
  Elder elder;
  double totalPrice;
  Apackage apackage;

  factory BookingWAccept.fromJson(Map<String, dynamic> json) => BookingWAccept(
        bookingId: json["bookingId"],
        address: json["address"],
        startDate: json["startDate"] ?? "",
        slots: json["slots"],
        endDate: json["endDate"] ?? "",
        description: json["description"] ?? "",
        elder: Elder.fromJson(json["elder"]),
        totalPrice: json["totalPrice"].toDouble(),
        apackage: Apackage.fromJson(json["apackage"]),
      );

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "address": address,
        "startDate": startDate,
        "slots": slots,
        "endDate": endDate,
        "description": description,
        "elder": elder.toJson(),
        "totalPrice": totalPrice,
        "apackage": apackage.toJson(),
      };
}

class Apackage {
  Apackage({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.status,
    required this.startTime,
    required this.startSlot,
    required this.endTime,
    required this.endSlot,
    this.healthStatus = "",
    required this.description,
    required this.imgUrl,
  });

  String id;
  String name;
  double price;
  int duration;
  String status;
  String startTime;
  int startSlot;
  String endTime;
  int endSlot;
  String healthStatus;
  String description;
  String imgUrl;

  factory Apackage.fromJson(Map<String, dynamic> json) => Apackage(
        id: json["id"],
        name: json["name"],
        price: json["price"].toDouble(),
        duration: json["duration"],
        status: json["status"],
        startTime: json["startTime"],
        startSlot: json["startSlot"],
        endTime: json["endTime"],
        endSlot: json["endSlot"],
        healthStatus: json["healthStatus"] ?? "",
        description: json["description"],
        imgUrl: json["imgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "duration": duration,
        "status": status,
        "startTime": startTime,
        "startSlot": startSlot,
        "endTime": endTime,
        "endSlot": endSlot,
        "healthStatus": healthStatus,
        "description": description,
        "imgUrl": imgUrl,
      };
}

class Elder {
  Elder({
    required this.id,
    required this.fullName,
    required this.dob,
    this.age = 0,
    required this.gender,
    this.healStatus,
  });

  String id;
  String fullName;
  DateTime dob;
  int age;
  String gender;
  dynamic healStatus;

  factory Elder.fromJson(Map<String, dynamic> json) => Elder(
        id: json["id"],
        fullName: json["fullName"],
        dob: DateTime.parse(json["dob"]),
        age: json["age"] ?? 0,
        gender: json["gender"],
        healStatus: json["healStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "age": age,
        "gender": gender,
        "healStatus": healStatus,
      };
}
