import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class SitEvent {}

class AvatarImgSitEvent extends SitEvent {
  AvatarImgSitEvent({required this.avatarImg});
  String avatarImg;
}

class FrontCardImgSitEvent extends SitEvent {
  FrontCardImgSitEvent({required this.frontCardImg});
  String frontCardImg;
}

class BackCardImgSitEvent extends SitEvent {
  BackCardImgSitEvent({required this.backCardImg});
  String backCardImg;
}

class FillFullNameSitEvent extends SitEvent {
  FillFullNameSitEvent({required this.fullName});
  final String fullName;
}

class FillPhoneSitEvent extends SitEvent {
  FillPhoneSitEvent({required this.phone});
  final String phone;
}

class FillAddressSitEvent extends SitEvent {
  FillAddressSitEvent({required this.address});
  final String address;
}

class FillDobSitEvent extends SitEvent {
  FillDobSitEvent({required this.dob});
  final String dob;
}

class FillGenderSitEvent extends SitEvent {
  FillGenderSitEvent({required this.gender});
  final String gender;
}

class FillIdNumberSitEvent extends SitEvent {
  FillIdNumberSitEvent({required this.idNumber});
  final String idNumber;
}

class FillDescriptionSitEvent extends SitEvent {
  FillDescriptionSitEvent({required this.description});
  final String description;
}

class FillEmailSitEvent extends SitEvent {
  FillEmailSitEvent({required this.email});
  final String email;
}

class FillPasswordSitEvent extends SitEvent {
  FillPasswordSitEvent({required this.password});
  final String password;
}

class FillRePasswordSitEvent extends SitEvent {
  FillRePasswordSitEvent({required this.rePassword});
  final String rePassword;
}

class SignUpSitEvent extends SitEvent {
  SignUpSitEvent({required this.context});
  final BuildContext context;
}

class GetContactSitEvent extends SitEvent {
  GetContactSitEvent();
}

class UpdateContactDetailSitEvent extends SitEvent {
  UpdateContactDetailSitEvent({required this.context});
  final BuildContext context;
}

class GetInformationEvent extends SitEvent {
  GetInformationEvent({required this.context});
  final BuildContext context;
}

class UpdateInformationDetailSitEvent extends SitEvent {
  UpdateInformationDetailSitEvent({required this.context});
  final BuildContext context;
}

class LoadIdentifyInfoSitEvent extends SitEvent{}

class SitOtherEvent extends SitEvent {}
