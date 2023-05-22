import 'package:elssit/core/models/working_time_model/add_month_working_time_dto.dart';

import '../../core/models/working_time_model/slot_data_model.dart';

abstract class WorkingTimeState{}
class OtherWorkingTimeState extends WorkingTimeState{}


class ChooseDateInWeekWorkingTimeState extends WorkingTimeState{
  ChooseDateInWeekWorkingTimeState({required this.mapWeek});
  final Map<String, List<String>> mapWeek;
}
class SetChosenDateInWeekTimeState extends WorkingTimeState{
  SetChosenDateInWeekTimeState({required this.chosenDateInWeek});
  final String chosenDateInWeek;
}
class GetAllWorkingTimeState extends WorkingTimeState{
  GetAllWorkingTimeState({required this.mapWeek});
  final Map<String, List<String>> mapWeek;
}
class SetSlotForAllState extends WorkingTimeState{
  SetSlotForAllState({required this.isSetSlotForAll});
  final bool isSetSlotForAll;
}
class ChooseSlotForAllState extends WorkingTimeState{
  ChooseSlotForAllState({required this.listSlotForAll});
  final List<String> listSlotForAll;
}



