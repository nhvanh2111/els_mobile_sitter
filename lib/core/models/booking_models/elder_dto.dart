class ElderDto {
  ElderDto({
    required this.id,
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.healthStatus,
    required this.age,
  });

  String id;
  String fullName;
  String dob;
  String gender;
  String healthStatus;
  int age;

  factory ElderDto.fromJson(Map<String, dynamic> json) => ElderDto(
    id: json["id"],
    fullName: json["fullName"],
    dob: json["dob"],
    gender: json["gender"],
    healthStatus: (json["healStatus"] != null) ? json["healStatus"] : "",
    age: (json["age"] != null) ? json["age"] : 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "dob": dob,
    "gender": gender,
    "healthStatus": healthStatus,
  };
}
