// To parse this JSON data, do
//
//     final timelineModel = timelineModelFromJson(jsonString);

import 'dart:convert';

List<TimelineModel> timelineModelFromJson(String str) => List<TimelineModel>.from(json.decode(str).map((x) => TimelineModel.fromJson(x)));

String timelineModelToJson(List<TimelineModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimelineModel {
    TimelineModel({
        required this.date,
        required this.trackingDtoList,
        required this.bookingDetailId
    });

    String date;
    List<TrackingDtoList> trackingDtoList;
    String bookingDetailId;

    factory TimelineModel.fromJson(Map<String, dynamic> json) => TimelineModel(
        date: json["date"],
        trackingDtoList: List<TrackingDtoList>.from(json["trackingDTOList"].map((x) => TrackingDtoList.fromJson(x))),
        bookingDetailId:json["bookingDetailId"]
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "trackingDTOList": List<dynamic>.from(trackingDtoList.map((x) => x.toJson())),
        "bookingDetailId":bookingDetailId
    };
}

class TrackingDtoList {
    TrackingDtoList({
        required this.time,
        required this.image,
        required this.note,
    });

    String time;
    String image;
    String note;

    factory TrackingDtoList.fromJson(Map<String, dynamic> json) => TrackingDtoList(
        time: json["time"],
        image: json["image"],
        note: json["note"],
    );

    Map<String, dynamic> toJson() => {
        "time": time,
        "image": image,
        "note": note,
    };
}
