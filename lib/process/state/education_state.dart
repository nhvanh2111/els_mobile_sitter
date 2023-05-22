import 'package:flutter/Material.dart';
import 'package:elssit/core/models/education_models/education_all_model.dart';
import 'package:elssit/core/models/education_models/education_detail_model.dart';

abstract class EducationState {}

class OtherEducationState extends EducationState {}

class DateStartEducationState extends EducationState {
  DateStartEducationState({required this.dateStartController});
  final TextEditingController dateStartController;
}

class DateEndEducationState extends EducationState {
  DateEndEducationState({required this.dateEndController});
  final TextEditingController dateEndController;
}

class GetAllEducationState extends EducationState {
  GetAllEducationState({required this.educationList});
  final EducationAllModel educationList;
}

class EducationDetailState extends EducationState {
  EducationDetailState({required this.education});
  final EducationDetailModel education;
}
