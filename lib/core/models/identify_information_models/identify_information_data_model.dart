class IdentifyInformationDataModel {
  IdentifyInformationDataModel({
    required this.sitterId,
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.idNumber,
    required this.avatarImg,
    required this.backCardImg,
    required this.frontCardImg,
    required this.status,
  });

  String sitterId;
  String fullName;
  String dob;
  String gender;
  String phone;
  String idNumber;
  String avatarImg;
  String backCardImg;
  String frontCardImg;
  String status;

  factory IdentifyInformationDataModel.fromJson(Map<String, dynamic> json) =>
      IdentifyInformationDataModel(
        sitterId: json["sitterId"],
        fullName: json["fullName"],
        dob: (json["dob"] != null) ? json["dob"] : "",
        gender: json["gender"],
        phone: json["phone"],
        idNumber: json["idNumber"],
        avatarImg: json["avatarImg"],
        backCardImg: json["backCardImg"],
        frontCardImg: json["frontCardImg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "sitterId": sitterId,
        "fullName": fullName,
        "dob": dob,
        "gender": gender,
        "phone": phone,
        "idNumber": idNumber,
        "avatarImg": avatarImg,
        "backCardImg": backCardImg,
        "frontCardImg": frontCardImg,
        "status": status,
      };
}
