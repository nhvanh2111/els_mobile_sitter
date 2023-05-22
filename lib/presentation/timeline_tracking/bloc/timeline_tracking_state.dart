import 'dart:isolate';

abstract class TimeLineState{}

class OtherTimelineState extends TimeLineState{
    OtherTimelineState({ this.isLoading=false});
  bool isLoading;
}

class InitTimelineState extends TimeLineState{}



