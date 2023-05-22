class ScheduleItemDataModel {
  ScheduleItemDataModel({
    required this.bookingId,
    required this.bookingDetailId,
    required this.customerName,
    required this.startDateTime,
    required this.endDateTime,
    required this.bookingStatus,
    required this.bookingDetailStatus,
  });

  String bookingId;
  String bookingDetailId;
  String customerName;
  String startDateTime;
  String endDateTime;
  String bookingStatus;
  String bookingDetailStatus;
  factory ScheduleItemDataModel.fromJson(Map<String, dynamic> json) => ScheduleItemDataModel(
    bookingId: json["bookingId"],
    bookingDetailId: json["bookingDetailId"],
    customerName: json["customerName"],
    startDateTime: json["startDateTime"],
    endDateTime: json["endDateTime"],
    bookingStatus: json["bookingStatus"],
    bookingDetailStatus: json["bookingDetailStatus"],
  );

  Map<String, dynamic> toJson() => {
    "bookingId": bookingId,
    "bookingDetailId": bookingDetailId,
    "sitterName": customerName,
    "startDateTime": startDateTime,
    "endDateTime": endDateTime,
    "bookingStatus": bookingStatus,
    "bookingDetailStatus": bookingDetailStatus,
  };
}