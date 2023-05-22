import 'package:flutter/material.dart';

abstract class CheckinCheckoutEvent {}

class GetStartDateTimeCheckinCheckoutEvent extends CheckinCheckoutEvent {
  GetStartDateTimeCheckinCheckoutEvent({required this.startDateTime});
  final String startDateTime;
}

class GetEndDateTimeCheckinCheckoutEvent extends CheckinCheckoutEvent {
  GetEndDateTimeCheckinCheckoutEvent({required this.endDateTime});
  String endDateTime;
}

class GetLocationCheckinCheckoutEvent extends CheckinCheckoutEvent {
  GetLocationCheckinCheckoutEvent({required this.location});
  final String location;
}

class SaveCheckInEvent extends CheckinCheckoutEvent {
  SaveCheckInEvent({required this.context, required this.bookingID, required this.startDateTime, required this.location,required this.lat,required this.lng});
  final BuildContext context;
  final String bookingID;
  final String startDateTime;
  final String location;
  final double lat;
  final double lng;
}

class SaveCheckOutEvent extends CheckinCheckoutEvent {
  SaveCheckOutEvent({required this.context, required this.bookingID, required this.endDateTime, required this.location});
  final BuildContext context;
  final String bookingID;
  final String endDateTime;
  final String location;
}
