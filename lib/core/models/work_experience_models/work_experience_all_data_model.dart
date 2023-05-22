class WorkExperienceAllDataModel {
  WorkExperienceAllDataModel({
    required this.id,
    required this.jobTitle,
    required this.description,
    required this.expTime,
  });

  String id;
  String jobTitle;
  String description;
  String expTime;

  factory WorkExperienceAllDataModel.fromJson(Map<String, dynamic> json) =>
      WorkExperienceAllDataModel(
        id: json["id"],
        jobTitle: (json["name"] != null) ? json["name"] : "",
        description: (json["description"] != null) ? json["description"] : "",
        expTime: (json["expTime"] != null) ? json["expTime"] : "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": jobTitle,
        "description": description,
        "expTime": expTime,
      };
}
