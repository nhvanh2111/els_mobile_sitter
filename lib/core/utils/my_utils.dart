import 'package:elssit/core/models/working_time_model/add_month_working_time_dto.dart';
import 'package:intl/intl.dart';

class MyUtils {
  String educationDateFormat(String date) {
    List<String> strDate = date.split("-");
    return "Tháng ${strDate[1]}, ${strDate[2]}";
  }
  String revertYMD(String date){
    return "${date.split("-")[2]}-${date.split("-")[1]}-${date.split("-")[0]}";
  }

  String convertDOBFromIDCard(String dob) {
    return "${dob[4]}${dob[5]}${dob[6]}${dob[7]}-${dob[2]}${dob[3]}-${dob[0]}${dob[1]}";
  }

  String convertInputDate(String date) {
    List<String> dateStr = date.split("-");
    return "${dateStr[2]}-${dateStr[1]}-${dateStr[0]}";
  }

  DateTime convertDateFromStr(String date) {
    DateTime dateTime = DateFormat('yyyy-MM-dd').parseLoose(date);
    return dateTime;
  }

  String displayDateTimeInScheduleItem(String dateTime) {
    String date = dateTime.split("T")[0];
    String time = dateTime.split("T")[1];
    return "${date.split("-")[2]}-${date.split("-")[1]} ${time.split(
        ":")[0]}:${time.split(":")[1]}";
  }

  String convertDateToStringInput(DateTime date) {
    return "${date.year}-${(date.month > 9) ? date.month : "0${date
        .month}"}-${(date.day > 9) ? date.day : "0${date.day}"}T${(date.hour >
        9) ? date.hour : "0${date.hour}"}:${(date.minute > 9)
        ? date.minute
        : "0${date.minute}"}";
  }

  String convertWeekDay(String date) {
    if (date == "T2") {
      return "MONDAY";
    } else if (date == "T3") {
      return "TUESDAY";
    } else if (date == "T4") {
      return "WEDNESDAY";
    } else if (date == "T5") {
      return "THURSDAY";
    } else if (date == "T6") {
      return "FRIDAY";
    } else if (date == "T7") {
      return "SATURDAY";
    } else if (date == "CN") {
      return "SUNDAY";
    } else {
      return "";
    }
  }

  bool checkChosenWeekInMonth(List<AddMonthWorkingTimeDto> listMonthDTO,
      String week) {
    if (listMonthDTO.isEmpty) {
      return false;
    } else {
      for (AddMonthWorkingTimeDto dto in listMonthDTO) {
        if (week == "W1") {
          if (dto.slotWeekOne.isNotEmpty) {
            return true;
          }
        } else if (week == "W2") {
          if (dto.slotWeekTwo.isNotEmpty) {
            return true;
          }
        } else if (week == "W3") {
          if (dto.slotWeekThree.isNotEmpty) {
            return true;
          }
        } else if (week == "W4") {
          if (dto.slotWeekFour.isNotEmpty) {
            return true;
          }
        } else {
          return false;
        }
      }
    }
    return false;
  }


}

//YYYY-MM-DDTHH:MM