// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:elssit/core/models/education_models/education_all_model.dart';
import 'package:elssit/core/models/education_models/education_detail_model.dart';
import 'package:elssit/core/utils/my_utils.dart';
import 'package:elssit/presentation/widget/dialog/forward_dialog.dart';
import 'package:elssit/presentation/widget/dialog/success_dialog.dart';
import 'package:elssit/presentation/widget/dialog/success_dialog_for_created.dart';
import 'package:elssit/process/event/education_event.dart';
import 'package:elssit/process/state/education_state.dart';
import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/utils/globals.dart' as globals;
import '../../core/validators/validations.dart';

class EducationBloc {
  final eventController = StreamController<EducationEvent>();

  final stateController = StreamController<EducationState>();

  final Map<String, String> errors = HashMap();

  String? educationLevel;
  String? major;
  String? schoolName;
  String dateFrom = "2023-01-01";
  String? dateTo;
  bool? graduated;
  String? gpa;
  String? description;
  String? educationImg;

  EducationBloc() {
    eventController.stream.listen((event) {
      if (event is ChooseEducationLevelEducationEvent) {
        educationLevel = event.educationLevel;
      }
      if (event is ChooseMajorLevelEducationEvent) {
        major = event.major;
      }
      if (event is FillSchoolNameEducationEvent) {
        schoolName = event.schoolName;
      }
      if (event is ChooseStartDateEducationEvent) {
        dateFrom = event.startDate;
        stateController.sink.add(DateStartEducationState(
            dateStartController: TextEditingController(
                text: MyUtils().educationDateFormat(event.startDate))));
      }
      if (event is ChooseEndDateEducationEvent) {
        dateTo = event.endDate;
        stateController.sink.add(DateEndEducationState(
            dateEndController: TextEditingController(
                text: MyUtils().educationDateFormat(event.endDate))));
      }
      if (event is FillGPAEducationEvent) {
        gpa = event.gpa;
      }
      if (event is GraduatedEducationEvent) {
        graduated = event.isGraduated;
      }
      if (event is FillDescriptionEducationEvent) {
        description = event.description;
      }
      if (event is EducationImgSitEvent) {
        educationImg = event.educationImg;
      }

      if (event is AddNewEducationEvent) {
        if (educationValidation()) {
          addNewEducation(event.context);
        }
      }
      if (event is UpdateEducationEvent) {
        if (educationValidation()) {
          updateEducation(event.context, event.educationID);
        }
      }
      if (event is DeleteEducationEvent) {
        deleteEducation(event.context, event.educationID);
      }
      if (event is GetAllEducationEvent) {
        getAllEducation();
      }
      if (event is GetEducationDetailDataEvent) {
        getEducationByID(event.educationID);
      }
    });
  }

  bool educationValidation() {
    bool isValid = false;
    bool isValidEducationLevel = false;
    bool isValidSchool = false;
    bool isValidTime = false;
    bool isValidMajor = false;
    bool isValidEducationImg = false;
    if (educationLevel != null) {
      errors.remove("educationLevel");
      isValidEducationLevel = true;
    } else {
      errors.addAll({"educationLevel": "Vui lòng chọn trình độ học vấn"});
      stateController.sink.addError(errors);
    }
    if (major != null) {
      errors.remove("major");
      isValidMajor = true;
    } else {
      errors.addAll({"major": "Vui lòng chọn chuyên ngành"});
      stateController.sink.addError(errors);
    }

    if (schoolName != null && schoolName!.isNotEmpty) {
      errors.remove("school");
      isValidSchool = true;
    } else {
      errors.addAll({"school": "Vui lòng nhập trường"});
      stateController.sink.addError(errors);
    }
    if (dateTo != null) {
      errors.remove("time");
      isValidTime = true;
    } else {
      errors.addAll({"time": "Thời gian không hợp lệ"});
      stateController.sink.addError(errors);
    }
    if (educationImg != null) {
      isValidEducationImg = true;
      errors.remove("educationImg");
    } else {
      errors
          .addAll({"educationImg": "Vui lòng tải lên chứng chỉ đã tốt nghiệp"});
    }
    if (isValidEducationLevel &&
        isValidSchool &&
        isValidTime &&
        isValidEducationImg &&
        isValidMajor) {
      isValid = true;
      stateController.sink.add(OtherEducationState());
    }
    return isValid;
  }

  Future<void> addNewEducation(BuildContext context) async {
    print('test datefrom $dateFrom');
    print('test dateTo $dateTo');
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/education/mobile/create");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "educationLevel": educationLevel,
            "major": major,
            "schoolName": schoolName,
            "fromDate": dateFrom,
            "endDate": dateTo,
            "isGraduate": (graduated != null) ? graduated : false,
            "gpa": (gpa != null && gpa!.isNotEmpty) ? gpa! : 0,
            "description": description,
            "educationImg": educationImg,
            "sitterId": globals.sitterID,
          },
        ),
      );
      print('Test status code updateEducation: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        if (globals.sitterStatus == "CREATED" || globals.sitterStatus == "REJECTED") {
          Navigator.pop(context);
          showSuccessDialogForCreated(context, "Thêm học vấn thành công");
          eventController.sink.add(GetAllEducationEvent());
        } else {
          // ignore: use_build_context_synchronously
          showSuccessDialog(
              context, "Tạo mới học vấn thành công", "/educationScreen");
        }
      } else {
        // ignore: avoid_print
        print(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> updateEducation(BuildContext context, String educationID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/education/mobile/update");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "id": educationID,
            "educationLevel": educationLevel,
            "major": major,
            "schoolName": schoolName,
            "fromDate": MyUtils().convertInputDate(dateFrom!),
            "endDate": MyUtils().convertInputDate(dateTo!),
            "isGraduate": (graduated != null) ? graduated : false,
            "gpa": (gpa != null && gpa!.isNotEmpty) ? gpa! : 0,
            "description": description,
            "educationImg": educationImg,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        showSuccessDialog(context, "Cập nhật thành công", "/educationScreen");
      } else {
        // ignore: avoid_print
        print(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> getEducationByID(String educationID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/education/mobile/$educationID");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(EducationDetailState(
            education:
                EducationDetailModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch cus from the REST API');
      }
    } finally {}
  }

  Future<void> getAllEducation() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/education/mobile/educations/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllEducationState(
            educationList:
                EducationAllModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch elder from the REST API');
      }
    } finally {}
  }

  Future<void> deleteEducation(BuildContext context, String educationID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/certificate/mobile/remove/$educationID");
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{},
        ),
      );
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/educationScreen');
      } else {
        // ignore: avoid_print
        print(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
}
