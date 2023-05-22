class WorkExperienceDetailDataModel {
  WorkExperienceDetailDataModel({
    required this.jobTitle,
    required this.description,
    required this.expTime,
    required this.status,
  });

  String jobTitle;
  String description;
  String expTime;
  String status;

  factory WorkExperienceDetailDataModel.fromJson(Map<String, dynamic> json) =>
      WorkExperienceDetailDataModel(
        jobTitle: (json["name"] != null) ? json["name"] : "",
        description: (json["description"] != null) ? json["description"] : "",
        expTime: (json["expTime"] != null) ? json["expTime"] : "",
        status: (json["status"] != null) ? json["status"] : "",
      );

  Map<String, dynamic> toJson() => {
        "name": jobTitle,
        "description": description,
        "expTime": expTime,
        "status": status,
      };
}
