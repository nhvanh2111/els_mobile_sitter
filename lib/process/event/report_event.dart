import 'package:flutter/Material.dart';

import '../../core/utils/my_enum.dart';

abstract class ReportEvent {}

class OtherReportEvent extends ReportEvent {}

class ChooseTitleReportEvent extends ReportEvent {
  ChooseTitleReportEvent({required this.title});
  final String title;
}

class ChooseAttitudeContentReportEvent extends ReportEvent {
  ChooseAttitudeContentReportEvent(
      {required this.content, required this.attitudeType});
  final String content;
  final AttitudeType attitudeType;
}

class ChooseCusInfoContentReportEvent extends ReportEvent {
  ChooseCusInfoContentReportEvent(
      {required this.content, required this.cusInfoType});
  final String content;
  final CusInfoType cusInfoType;
}

class FillContentReportEvent extends ReportEvent {
  FillContentReportEvent({required this.content});
  final String content;
}

class ConfirmReportEvent extends ReportEvent {
  ConfirmReportEvent(
      {required this.context,
      required this.bookingDetailID,
      required this.customerID});
  final BuildContext context;
  final String bookingDetailID;
  final String customerID;
}

class GetAllReportEvent extends ReportEvent {
  GetAllReportEvent();
}
