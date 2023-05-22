import 'package:elssit/core/utils/my_enum.dart';

abstract class CancelBookingState {}

class OtherCancelBookingState extends CancelBookingState {}

class ChooseInfoBookingCancelBookingState extends CancelBookingState {
  ChooseInfoBookingCancelBookingState({required this.infoBookingType});
  final InfoBookingType infoBookingType;
}

class ChooseTypeCancelBookingState extends CancelBookingState {
  ChooseTypeCancelBookingState({required this.cancelBookingType});
  final CancelBookingType cancelBookingType;
}
