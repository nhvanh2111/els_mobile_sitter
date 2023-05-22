import 'package:flutter/Material.dart';

abstract class CertificationEvent {}

class ChooseReceivedDateCertificationEvent extends CertificationEvent {
  ChooseReceivedDateCertificationEvent({required this.receivedDate});
  final String receivedDate;
}

class FillTitleCertificationEvent extends CertificationEvent {
  FillTitleCertificationEvent({required this.title});
  String title;
}

class FillOrganizationCertificationEvent extends CertificationEvent {
  FillOrganizationCertificationEvent({required this.organization});
  String organization;
}

class FillCredentialIDCertificationEvent extends CertificationEvent {
  FillCredentialIDCertificationEvent({required this.credentialID});
  String credentialID;
}

class FillCredentialURLCertificationEvent extends CertificationEvent {
  FillCredentialURLCertificationEvent({required this.credentialURL});
  String credentialURL;
}

class CertificationImgEvent extends CertificationEvent {
  CertificationImgEvent({required this.certificationImg});
  String certificationImg;
}

class AddNewCertificationEvent extends CertificationEvent {
  AddNewCertificationEvent({required this.context});
  final BuildContext context;
}

class GetCertificationDetailDataEvent extends CertificationEvent {
  GetCertificationDetailDataEvent({required this.certificationID});
  final String certificationID;
}

class GetAllCertificationEvent extends CertificationEvent {
  GetAllCertificationEvent();
}

class UpdateCertificationEvent extends CertificationEvent {
  UpdateCertificationEvent(
      {required this.certificationID, required this.context});
  final String certificationID;
  final BuildContext context;
}

class DeleteCertificationEvent extends CertificationEvent {
  DeleteCertificationEvent(
      {required this.certificationID, required this.context});
  final String certificationID;
  final BuildContext context;
}

class CertificationOtherEvent extends CertificationEvent {}
