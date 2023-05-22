class WorkingTimeDataModel {
  WorkingTimeDataModel({
    required this.id,
    required this.dayOfWeek,
    this.slots,
    required this.status,
  });

  String id;
  String dayOfWeek;
  String? slots;
  String status;

  factory WorkingTimeDataModel.fromJson(Map<String, dynamic> json) => WorkingTimeDataModel(
    id: json["id"],
    dayOfWeek: json["dayOfWeek"],
    slots: json["slots"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dayOfWeek": dayOfWeek,
    "slots": slots,
    "status": status,
  };
}