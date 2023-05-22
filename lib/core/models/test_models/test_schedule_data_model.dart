class TestScheduleDataModel {
  TestScheduleDataModel({
    required this.name,
    required this.date,
  });

  String name;
  DateTime date;

  factory TestScheduleDataModel.fromJson(Map<String, dynamic> json) => TestScheduleDataModel(
    name: json["name"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}