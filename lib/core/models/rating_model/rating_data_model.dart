class RatingDataModel {
  RatingDataModel({
    required this.countOneRate,
    required this.countTwoRate,
    required this.countThreeRate,
    required this.countFourRate,
    required this.countFiveRate,
    required this.hasTag,
    required this.average,
  });

  int countOneRate;
  int countTwoRate;
  int countThreeRate;
  int countFourRate;
  int countFiveRate;
  String hasTag;
  String average;

  factory RatingDataModel.fromJson(Map<String, dynamic> json) => RatingDataModel(
    countOneRate: json["countOneRate"],
    countTwoRate: json["countTwoRate"],
    countThreeRate: json["countThreeRate"],
    countFourRate: json["countFourRate"],
    countFiveRate: json["countFiveRate"],
    hasTag: json["hasTag"],
    average: json["average"],
  );

  Map<String, dynamic> toJson() => {
    "countOneRate": countOneRate,
    "countTwoRate": countTwoRate,
    "countThreeRate": countThreeRate,
    "countFourRate": countFourRate,
    "countFiveRate": countFiveRate,
    "hasTag": hasTag,
    "average": average,
  };
}
