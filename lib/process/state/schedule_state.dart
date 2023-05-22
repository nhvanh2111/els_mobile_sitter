

import 'package:elssit/core/models/schedule_models/schedule_item_data_model.dart';

import '../../core/models/schedule_models/schedue_item_model.dart';

abstract class ScheduleState {}

class LoadingState extends ScheduleState{
}
class HaveDataState extends ScheduleState{
  HaveDataState({required this.listSchedule});
  final List<ScheduleItemDataModel> listSchedule;
}
class NotHaveDataState extends ScheduleState{
}
class OtherScheduleState extends ScheduleState{}
