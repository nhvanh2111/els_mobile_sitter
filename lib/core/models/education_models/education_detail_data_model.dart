class EducationDetailDataModel {
  EducationDetailDataModel({
    required this.educationLevel,
    required this.major,
    required this.schoolName,
    required this.startDate,
    required this.endDate,
    required this.isGraduated,
    required this.gpa,
    required this.description,
    required this.educationImg,
  });

  String educationLevel;
  String major;
  String schoolName;
  DateTime startDate;
  DateTime endDate;
  bool isGraduated;
  String educationImg;
  String description;
  double gpa;

  factory EducationDetailDataModel.fromJson(Map<String, dynamic> json) =>
      EducationDetailDataModel(
        educationLevel:
            (json["educationLevel"] != null) ? json["educationLevel"] : "",
        major: (json["major"] != null) ? json["major"] : "",
        schoolName: (json["schoolName"] != null) ? json["schoolName"] : "",
        startDate: (json["startDate"] != null ) ? DateTime.parse(json["startDate"]) : DateTime.now(),
        endDate: DateTime.parse(json["endDate"]),
        isGraduated: (json["isGraduate"] != null) ? json["isGraduate"] : false,
        gpa: (json["gpa"] != null) ? json["gpa"] : 0.0,
        description: (json["description"] != null) ? json["description"] : "",
        educationImg:
            (json["educationImg"] != null) ? json["educationImg"] : "",
      );

  Map<String, dynamic> toJson() => {
        "educationLevel": educationLevel,
        "major": major,
        "schoolName": schoolName,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "isGraduate": isGraduated,
        "educationImg": educationImg,
        "description": description,
        "gpa": gpa,
      };
}
