import 'package:elssit/core/utils/my_enum.dart';
import 'package:flutter/Material.dart';

abstract class CancelBookingEvent {}

class OtherCancelBookingEvent extends CancelBookingEvent {}

class ChooseTitleCancelBookingEvent extends CancelBookingEvent {
  ChooseTitleCancelBookingEvent({required this.title});
  final String title;
}

class ChooseInfoBookingContentCancelBookingEvent extends CancelBookingEvent {
  ChooseInfoBookingContentCancelBookingEvent(
      {required this.content, required this.infoBookingType});
  final String content;
  final InfoBookingType infoBookingType;
}

class ChooseTyeCancelBookingEvent extends CancelBookingEvent {
  ChooseTyeCancelBookingEvent(
      {required this.content, required this.cancelBookingType});
  final String content;
  final CancelBookingType cancelBookingType;
}

class FillContentCancelBookingEvent extends CancelBookingEvent {
  FillContentCancelBookingEvent({required this.content});
  final String content;
}

class ConfirmCancelBookingEvent extends CancelBookingEvent {
  ConfirmCancelBookingEvent({
    required this.context,
    required this.bookingID,
  });
  final BuildContext context;
  final String bookingID;
}
