import 'package:elssit/core/utils/my_enum.dart';
import 'package:flutter/material.dart';

abstract class WorkingTimeEvent{}
class OtherWorkingTimeEvent extends WorkingTimeEvent{}


class ConfirmWorkingTimeEvent extends WorkingTimeEvent{
  ConfirmWorkingTimeEvent({required this.context});
  final BuildContext context;
}
class ChooseDateInWeekWorkingTimeEvent extends WorkingTimeEvent{
  ChooseDateInWeekWorkingTimeEvent({required this.date});
  final String date;
}
class ChooseSlotForDateInWeekWorkingTimeEvent extends WorkingTimeEvent{
  ChooseSlotForDateInWeekWorkingTimeEvent({required this.date, required this.slot});
  final String date;
  final String slot;
}

class SetChosenDateInWeekTimeEvent extends WorkingTimeEvent{
  SetChosenDateInWeekTimeEvent({required this.chosenDateInWeek});
  final String chosenDateInWeek;
}

class GetAllWorkingTimeEvent extends WorkingTimeEvent{

}

class SetSlotForAllEvent extends WorkingTimeEvent{
  SetSlotForAllEvent({required this.isSetSlotForAll});
  final bool isSetSlotForAll;
}
class ChooseSlotForAllEvent extends WorkingTimeEvent{
  ChooseSlotForAllEvent({required this.slot});
  final String slot;
}

