import 'package:elssit/core/models/work_experience_models/work_experience_detail_model.dart';
import 'package:elssit/core/models/work_experience_models/work_experience_all_model.dart';
import 'package:flutter/Material.dart';

abstract class WorkExperienceState {}

class OtherWorkExperienceState extends WorkExperienceState {}

class GetWorkExperienceDetailState extends WorkExperienceState {
  GetWorkExperienceDetailState({required this.workExperience});
  final WorkExperienceDetailModel workExperience;
}

class GetAllWorkExperienceState extends WorkExperienceState {
  GetAllWorkExperienceState({required this.workExperienceList});
  final WorkExperienceAllModel workExperienceList;
}
