import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class WorkExperienceEvent {}

class FillJobTitleWorkExperienceEvent extends WorkExperienceEvent {
  FillJobTitleWorkExperienceEvent({required this.jobTitle});
  final String jobTitle;
}

class FillExpTimeWorkExperienceEvent extends WorkExperienceEvent {
  FillExpTimeWorkExperienceEvent({required this.expTime});
  final String expTime;
}

class FillDescriptionWorkExperienceEvent extends WorkExperienceEvent {
  FillDescriptionWorkExperienceEvent({required this.description});
  final String description;
}

class AddNewWorkExperienceEvent extends WorkExperienceEvent {
  AddNewWorkExperienceEvent({required this.context});
  final BuildContext context;
}

class GetWorkExperienceDetailEvent extends WorkExperienceEvent {
  GetWorkExperienceDetailEvent({required this.workExperienceID});
  final String workExperienceID;
}

class GetAllWorkExperienceEvent extends WorkExperienceEvent {
  GetAllWorkExperienceEvent();
}

class UpdateWorkExperienceEvent extends WorkExperienceEvent {
  UpdateWorkExperienceEvent(
      {required this.workExperienceID, required this.context});
  final String workExperienceID;
  final BuildContext context;
}

class DeleteWorkExperienceEvent extends WorkExperienceEvent {
  DeleteWorkExperienceEvent(
      {required this.workExperienceID, required this.context});
  final String workExperienceID;
  final BuildContext context;
}

class WorkExperienceOtherEvent extends WorkExperienceEvent {}
