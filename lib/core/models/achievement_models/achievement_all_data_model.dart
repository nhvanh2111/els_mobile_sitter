class AchievementAllDataModel {
  AchievementAllDataModel({
    required this.id,
    required this.title,
    required this.organization,
    required this.dateReceived,
  });

  String id;
  String title;
  String organization;
  DateTime dateReceived;

  factory AchievementAllDataModel.fromJson(Map<String, dynamic> json) =>
      AchievementAllDataModel(
        id: json["id"],
        title: json["title"],
        organization: json["organization"],
        dateReceived: DateTime.parse(json["dateReceived"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "organization": organization,
        "dateReceived":
            "${dateReceived.year.toString().padLeft(4, '0')}-${dateReceived.month.toString().padLeft(2, '0')}-${dateReceived.day.toString().padLeft(2, '0')}",
      };
}
