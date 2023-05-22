import 'package:flutter/cupertino.dart';

abstract class AchievementEvent {}

class ChooseReceivedDateAchievementEvent extends AchievementEvent {
  ChooseReceivedDateAchievementEvent({required this.receivedDate});
  String receivedDate;
}

class FillTitleAchievementEvent extends AchievementEvent {
  FillTitleAchievementEvent({required this.title});
  String title;
}

class FillOrganizationAchievementEvent extends AchievementEvent {
  FillOrganizationAchievementEvent({required this.organization});
  String organization;
}

class FillDescriptionAchievementEvent extends AchievementEvent {
  FillDescriptionAchievementEvent({required this.description});
  String description;
}

class AchievementImgEvent extends AchievementEvent {
  AchievementImgEvent({required this.achievementImg});
  String achievementImg;
}

class AddNewAchievementEvent extends AchievementEvent {
  AddNewAchievementEvent({required this.context});
  BuildContext context;
}

class GetAchievementDetailDataEvent extends AchievementEvent {
  GetAchievementDetailDataEvent({required this.achievementID});
  final String achievementID;
}

class GetAllAchievementEvent extends AchievementEvent {
  GetAllAchievementEvent();
}

class UpdateAchievementEvent extends AchievementEvent {
  UpdateAchievementEvent({required this.achievementID, required this.context});
  final String achievementID;
  final BuildContext context;
}

class AchievementOtherEvent extends AchievementEvent {}
