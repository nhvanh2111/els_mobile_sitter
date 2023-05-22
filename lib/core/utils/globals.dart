library els_sit_mobile.globals;

import '../models/identify_information_models/identify_information_data_model.dart';
import '../models/working_time_model/slot_data_model.dart';

String deviceID = "";
String bearerToken = "";
String email = "";
String sitterID = "";
String idString = "";
String sitterStatus = "";
IdentifyInformationDataModel? identifyInformation;
List<SlotDataModel> listSlot = [
  SlotDataModel(slots: "1 00:00-02:00"),
  SlotDataModel(slots: "2 02:00-04:00"),
  SlotDataModel(slots: "3 04:00-06:00"),
  SlotDataModel(slots: "4 06:00-08:00"),
  SlotDataModel(slots: "5 08:00-10:00"),
  SlotDataModel(slots: "6 10:00-12:00"),
  SlotDataModel(slots: "7 12:00-14:00"),
  SlotDataModel(slots: "8 14:00-16:00"),
  SlotDataModel(slots: "9 16:00-18:00"),
  SlotDataModel(slots: "10 18:00-20:00"),
  SlotDataModel(slots: "11 20:00-22:00"),
  SlotDataModel(slots: "12 22:00-24:00"),
];
