import 'package:elssit/core/models/report_models/report_all_model.dart';

import '../../core/utils/my_enum.dart';

abstract class ReportState {}

class OtherReportState extends ReportState {}

class ChooseAttitudeContentReportState extends ReportState {
  ChooseAttitudeContentReportState({required this.attitudeType});
  final AttitudeType attitudeType;
}

class ChooseCusInfoContentReportState extends ReportState {
  ChooseCusInfoContentReportState({required this.cusInfoType});
  final CusInfoType cusInfoType;
}

class GetAllReportState extends ReportState {
  GetAllReportState({required this.reportList});
  final ReportAllModel reportList;
}
