class EducationAllDataModel {
  EducationAllDataModel({
    required this.id,
    required this.educationLevel,
    required this.major,
    required this.schoolName,
  });

  String id;
  String educationLevel;
  String major;
  String schoolName;

  factory EducationAllDataModel.fromJson(Map<String, dynamic> json) =>
      EducationAllDataModel(
        id: json["id"],
        educationLevel:
            (json["educationLevel"] != null) ? json["educationLevel"] : "",
        major: (json["major"] != null) ? json["major"] : "",
        schoolName: (json["schoolName"] != null) ? json["schoolName"] : "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "educationLevel": educationLevel,
        "major": major,
        "schoolName": schoolName,
      };
}
