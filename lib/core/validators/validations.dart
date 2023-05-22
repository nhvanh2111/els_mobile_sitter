import 'package:intl/intl.dart';

class Validations {
  static bool isValidEmail(String email) {
    RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      caseSensitive: false,
      multiLine: false,
    );
    if (emailRegex.hasMatch(email) && email.isNotEmpty) {
      return true;
    }
    return false;
  }

  static bool isValidPassword(String password) {
    RegExp passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$',
      caseSensitive: false,
      multiLine: false,
    );
    if (passwordRegex.hasMatch(password) && password.isNotEmpty) {
      return true;
    }
    return false;
  }

  static bool isValidPhone(String? phoneNumber) {
    try {
      int phone = int.parse(phoneNumber!);
      if (phoneNumber.length == 10) {
        return true;
      } else {
        return false;
      }
    } on NumberFormat catch (e) {
      return false;
    }
  }

  static bool isValidIdNumber(String? idNumber) {
    if (idNumber!.length == 9 || idNumber.length == 16) {
      return true;
    } else {
      return false;
    }
  }

  static bool isValidCourseTime(String dateFrom, String dateTo) {
    List<String> dateFromList = dateFrom.split("-");
    List<String> dateToList = dateTo.split("-");
    if (int.parse(dateFromList[2]) < int.parse(dateToList[2])) {
      return true;
    }
    return false;
  }

  static bool isValidCertificationTime(String? dateReceived) {
    int date = DateTime.now().year - int.parse(dateReceived!.split("-")[2]);
    if (date >= 3) {
      return true;
    }
    return false;
  }
}
