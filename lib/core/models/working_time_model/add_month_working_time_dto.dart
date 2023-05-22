class AddMonthWorkingTimeDto {
  AddMonthWorkingTimeDto({
    required this.dayOfWeek,
    required this.slotWeekOne,
    required this.slotWeekTwo,
    required this.slotWeekThree,
    required this.slotWeekFour,
  });

  String dayOfWeek;
  String slotWeekOne;
  String slotWeekTwo;
  String slotWeekThree;
  String slotWeekFour;

  factory AddMonthWorkingTimeDto.fromJson(Map<String, dynamic> json) =>
      AddMonthWorkingTimeDto(
        dayOfWeek: json["dayOfWeek"],
        slotWeekOne: json["slotWeekOne"],
        slotWeekTwo: json["slotWeekTwo"],
        slotWeekThree: json["slotWeekThree"],
        slotWeekFour: json["slotWeekFour"],
      );

  Map<String, dynamic> toJson() => {
        "dayOfWeek": dayOfWeek,
        "slotWeekOne": slotWeekOne,
        "slotWeekTwo": slotWeekTwo,
        "slotWeekThree": slotWeekThree,
        "slotWeekFour": slotWeekFour,
      };

  @override
  String toString() {
    // TODO: implement toString
    return "$dayOfWeek; $slotWeekOne; $slotWeekTwo; $slotWeekThree; $slotWeekFour";
  }

  void setSlot(String slotWeek1, String slotWeek2, String slotWeek3, String slotWeek4){
    slotWeekOne = slotWeek1;
    slotWeekTwo = slotWeek2;
    slotWeekThree = slotWeek3;
    slotWeekFour = slotWeek4;
  }
}
