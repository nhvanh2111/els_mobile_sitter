import 'package:elssit/core/models/achievement_models/achievement_all_data_model.dart';
import 'package:elssit/core/models/achievement_models/achievement_all_model.dart';
import 'package:elssit/core/models/achievement_models/achievement_detail_data_model.dart';
import 'package:elssit/core/models/achievement_models/achievement_detail_model.dart';
import 'package:flutter/Material.dart';

abstract class AchievementState {}

class OtherAchievementState extends AchievementState {}

class DateReceivedAchievementState extends AchievementState {
  DateReceivedAchievementState({required this.dateReceivedController});
  final TextEditingController dateReceivedController;
}

class AchievementDetailState extends AchievementState {
  AchievementDetailState({required this.achievement});
  final AchievementDetailModel achievement;
}

class GetAllAchievementState extends AchievementState {
  GetAllAchievementState({required this.achievementList});
  final AchievementAllModel achievementList;
}
