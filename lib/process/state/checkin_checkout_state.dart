import 'package:flutter/Material.dart';

abstract class CheckinCheckoutState {}

class OtherCheckinCheckoutState extends CheckinCheckoutState {}

class StartDateTimeCheckinCheckoutState extends CheckinCheckoutState {
  StartDateTimeCheckinCheckoutState({required this.dateStartController});
  final TextEditingController dateStartController;
}

class EndDateTimeCheckinCheckoutState extends CheckinCheckoutState {
  EndDateTimeCheckinCheckoutState({required this.dateEndController});
  final TextEditingController dateEndController;
}

