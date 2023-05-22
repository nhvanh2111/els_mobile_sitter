import 'package:elssit/core/models/certification_models/certification_all_model.dart';
import 'package:elssit/core/models/certification_models/certification_detail_model.dart';
import 'package:flutter/Material.dart';

abstract class CertificationState {}

class OtherCertificationState extends CertificationState {}

class DateReceivedCertificationState extends CertificationState {
  DateReceivedCertificationState({required this.dateReceivedController});
  final TextEditingController dateReceivedController;
}

class GetAllCertificationState extends CertificationState {
  GetAllCertificationState({required this.certificationList});
  final CertificationAllModel certificationList;
}
class GetAllNullCertificationState extends CertificationState {
  GetAllNullCertificationState();
}
class CertificationDetailState extends CertificationState {
  CertificationDetailState({required this.certification});
  final CertificationDetailModel certification;
}
