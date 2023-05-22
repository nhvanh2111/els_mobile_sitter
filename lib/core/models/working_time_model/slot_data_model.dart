class SlotDataModel {
  SlotDataModel({
    required this.slots,
  });

  String slots;

  factory SlotDataModel.fromJson(Map<String, dynamic> json) => SlotDataModel(
    slots: json["slots"],
  );

  Map<String, dynamic> toJson() => {
    "slots": slots,
  };
}