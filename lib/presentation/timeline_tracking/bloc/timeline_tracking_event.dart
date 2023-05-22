import 'package:flutter/Material.dart';
import 'package:geolocator/geolocator.dart';

abstract class TimeLineEvent{}

class OtherTimelineEvent extends TimeLineEvent{}


class FetchTimelineEvent extends TimeLineEvent{
  FetchTimelineEvent({required this.context});
  BuildContext context;
}
class SaveCheckInTimeLineEvent extends TimeLineEvent {
  SaveCheckInTimeLineEvent({required this.context,required this.position,required this.idBooking});
  final BuildContext context;
  Position position;
  String idBooking;
}
//
class SaveCheckOutTimeLineEvent extends TimeLineEvent {
  SaveCheckOutTimeLineEvent({required this.context,});
  final BuildContext context;
  
}

