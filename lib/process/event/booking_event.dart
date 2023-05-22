abstract class BookingEvent {}

class TestGetAllBookingEvent extends BookingEvent {}

class OtherBookingEvent extends BookingEvent {}

class GetFullDetailBookingEvent extends BookingEvent {
  GetFullDetailBookingEvent({required this.bookingID});

  final String bookingID;
}

class GetBookingWatingEvent extends BookingEvent {
  GetBookingWatingEvent();
}

class GetAllHistoryBookingEvent extends BookingEvent {
  GetAllHistoryBookingEvent();
}

class GetAllHistoryByStatusBookingEvent extends BookingEvent {
  GetAllHistoryByStatusBookingEvent({required this.status});

  final String status;
}

