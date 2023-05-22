import 'package:flutter/Material.dart';

abstract class EducationEvent {}

class ChooseStartDateEducationEvent extends EducationEvent {
  ChooseStartDateEducationEvent({required this.startDate});
  String startDate;
}

class ChooseEndDateEducationEvent extends EducationEvent {
  ChooseEndDateEducationEvent({required this.endDate});
  String endDate;
}

class ChooseEducationLevelEducationEvent extends EducationEvent {
  ChooseEducationLevelEducationEvent({required this.educationLevel});
  String educationLevel;
}

class ChooseMajorLevelEducationEvent extends EducationEvent {
  ChooseMajorLevelEducationEvent({required this.major});
  String major;
}

class FillSchoolNameEducationEvent extends EducationEvent {
  FillSchoolNameEducationEvent({required this.schoolName});
  String schoolName;
}

class FillGPAEducationEvent extends EducationEvent {
  FillGPAEducationEvent({required this.gpa});
  String gpa;
}

class FillDescriptionEducationEvent extends EducationEvent {
  FillDescriptionEducationEvent({required this.description});
  String description;
}

class EducationImgSitEvent extends EducationEvent {
  EducationImgSitEvent({required this.educationImg});
  String educationImg;
}

class GraduatedEducationEvent extends EducationEvent {
  GraduatedEducationEvent({required this.isGraduated});
  bool isGraduated;
}
// class SaveEducationEvent extends EducationEvent {
//   SaveEducationEvent({required this.context});
//   BuildContext context;
// }

class AddNewEducationEvent extends EducationEvent {
  AddNewEducationEvent({required this.context});
  final BuildContext context;
}

class GetEducationDetailDataEvent extends EducationEvent {
  GetEducationDetailDataEvent({required this.educationID});
  final String educationID;
}

class GetAllEducationEvent extends EducationEvent {
  GetAllEducationEvent();
}

class UpdateEducationEvent extends EducationEvent {
  UpdateEducationEvent({required this.educationID, required this.context});
  final String educationID;
  final BuildContext context;
}

class DeleteEducationEvent extends EducationEvent {
  DeleteEducationEvent({required this.educationID, required this.context});
  final String educationID;
  final BuildContext context;
}

class EducationOtherEvent extends EducationEvent {}
