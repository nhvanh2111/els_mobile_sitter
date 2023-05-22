class ReportAllDataModel {
  ReportAllDataModel({
    required this.id,
    required this.title,
    required this.reporter,
    required this.reportedPerson,
    required this.createDate,
    required this.status,
  });

  String id;
  String title;
  String reporter;
  String reportedPerson;
  DateTime createDate;
  String status;

  factory ReportAllDataModel.fromJson(Map<String, dynamic> json) =>
      ReportAllDataModel(
        id: json["id"],
        title: json["title"],
        reporter: json["reporter"],
        reportedPerson: json["reportedPerson"],
        createDate: DateTime.parse(json["createDate"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "reporter": reporter,
        "reportedPerson": reportedPerson,
        "createDate": createDate,
        "status": status,
      };
}
