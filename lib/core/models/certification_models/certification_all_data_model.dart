class CertificationAllDataModel {
  CertificationAllDataModel({
    required this.id,
    required this.title,
    required this.organization,
    required this.dateReceived,
  });

  String id;
  String title;
  String organization;
  DateTime dateReceived;

  factory CertificationAllDataModel.fromJson(Map<String, dynamic> json) =>
      CertificationAllDataModel(
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
