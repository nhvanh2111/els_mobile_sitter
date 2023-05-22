import 'package:elssit/core/models/booking_models/booking_full_detail_data_model.dart';
import 'package:elssit/core/models/booking_models/booking_history_model.dart';
import 'package:elssit/core/models/booking_models/booking_waiting_model.dart';

import '../../core/models/booking_models/booking_full_detail_model.dart';
import '../../core/models/test_models/test_schedule_model.dart';

abstract class BookingState {}

class TestGetAllBookingState extends BookingState {
  TestGetAllBookingState({required this.testModel});

  final TestScheduleModel testModel;
}

class OtherBookingState extends BookingState {}

class GetFullDetailBookingState extends BookingState {
  GetFullDetailBookingState({required this.booking});

  final BookingFullDetailModel booking;
}

class GetWaitingBookingState extends BookingState {
  GetWaitingBookingState({required this.bookingWaitingList});

  final BookingHistoryModel bookingWaitingList;
}

class LoadingDataState extends BookingState {}

class GetAllHistoryBookingState extends BookingState {
  GetAllHistoryBookingState({required this.bookingHistoryList});

  final BookingHistoryModel bookingHistoryList;
}

class GetAllHistoryByStatusBookingState extends BookingState {
  GetAllHistoryByStatusBookingState({required this.bookingHistoryList});

  final BookingHistoryModel bookingHistoryList;
}

class GetAllPresentBookingState extends BookingState {
  GetAllPresentBookingState({required this.bookingList});

  final BookingHistoryModel bookingList;
}
