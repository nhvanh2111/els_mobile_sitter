class AchievementDetailDataModel {
  AchievementDetailDataModel({
    required this.title,
    required this.organization,
    required this.dateReceived,
    required this.description,
    required this.achievementImg,
  });

  String title;
  String organization;
  String dateReceived;
  String description;
  String achievementImg;

  factory AchievementDetailDataModel.fromJson(Map<String, dynamic> json) =>
      AchievementDetailDataModel(
        title: json["title"],
        organization: json["organization"],
        dateReceived: json["dateReceived"],
        description: json["description"],
        achievementImg:
            (json["achievementImg"] != null) ? json["achievementImg"] : "",
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "organization": organization,
        "dateReceived": dateReceived,
        "description": description,
        "achievementImg": achievementImg,
      };
}
