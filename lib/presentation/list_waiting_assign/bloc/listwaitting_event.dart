abstract class ListWaittingEvent{}

class OtherListWaitingEvent extends ListWaittingEvent{}

class InitListWaitingEvent extends ListWaittingEvent{}

class FetchDataListWaitingEvent extends ListWaittingEvent{}

class AcceptListWaitingEvent extends ListWaittingEvent{
    AcceptListWaitingEvent({required this.idBooking,required this.isAcept});
  String idBooking;
  bool isAcept;
}

class DenyListWaitingEvent extends ListWaittingEvent{
  DenyListWaitingEvent({required this.idBooking,required this.isAcept});
  String idBooking;
  bool isAcept;
}
