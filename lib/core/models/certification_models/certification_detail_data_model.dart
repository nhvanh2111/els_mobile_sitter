class CertificationDetailDataModel {
  CertificationDetailDataModel({
    required this.title,
    required this.organization,
    required this.dateReceived,
    required this.credentialID,
    required this.credentialURL,
    required this.certificationImg,
    required this.status,
  });

  String title;
  String organization;
  String dateReceived;
  String credentialID;
  String credentialURL;
  String certificationImg;
  String status;

  factory CertificationDetailDataModel.fromJson(Map<String, dynamic> json) =>
      CertificationDetailDataModel(
        title: (json["title"] != null) ? json["title"] : "",
        organization:
            (json["organization"] != null) ? json["organization"] : "",
        dateReceived: json["dateReceived"],
        credentialID:
            (json["credentialID"] != null) ? json["credentialID"] : "",
        credentialURL:
            (json["credentialURL"] != null) ? json["credentialURL"] : "",
        certificationImg: (json["certificateImgUrl"] != null)
            ? json["certificateImgUrl"]
            : "",
        status: (json["status"] != null) ? json["status"] : "",
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "organization": organization,
        "dateReceived": dateReceived,
        "credentialID": credentialID,
        "credentialURL": credentialURL,
        "certificateImgUrl": certificationImg,
        "status": status,
      };
}
