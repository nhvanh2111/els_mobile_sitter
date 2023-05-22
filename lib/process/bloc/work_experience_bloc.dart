import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:elssit/presentation/widget/dialog/comfirm_sendform_dialog.dart';
import 'package:elssit/presentation/widget/dialog/success_dialog.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'package:elssit/core/utils/globals.dart' as globals;
import 'package:elssit/core/models/work_experience_models/work_experience_detail_model.dart';

import 'package:elssit/process/event/work_experience_event.dart';
import 'package:elssit/process/state/work_experience_state.dart';

import '../../core/models/work_experience_models/work_experience_all_model.dart';
import '../../presentation/widget/dialog/success_dialog_for_created.dart';

class WorkExperienceBloc {
  final eventController = StreamController<WorkExperienceEvent>();

  final stateController = StreamController<WorkExperienceState>();

  String? jobTitle;
  String? description;
  String? expTime;

  final Map<String, String> errors = HashMap();

  WorkExperienceBloc() {
    eventController.stream.listen((event) {
      if (event is FillJobTitleWorkExperienceEvent) {
        jobTitle = event.jobTitle;
        errors.remove("jobTitle");
      }
      if (event is FillExpTimeWorkExperienceEvent) {
        expTime = event.expTime;
        errors.remove("expTime");
      }
      if (event is FillDescriptionWorkExperienceEvent) {
        description = event.description;
        errors.remove("description");
      }
      if (event is AddNewWorkExperienceEvent) {
        if (workexperienceValidation()) {
          addNewWorkExperience(event.context);
        }
      }
      if (event is UpdateWorkExperienceEvent) {
        if (workexperienceValidation()) {
          updateWorkExperience(event.context, event.workExperienceID);
        }
      }
      if (event is GetWorkExperienceDetailEvent) {
        getWorkExperienceByID(event.workExperienceID);
      }
      if (event is GetAllWorkExperienceEvent) {
        getAllWorkExperience();
      }
      if (event is WorkExperienceOtherEvent) {
        stateController.add(OtherWorkExperienceState());
      }
      if (event is DeleteWorkExperienceEvent) {
        deleteWorkExperience(event.context, event.workExperienceID);
      }
    });
  }

  bool workexperienceValidation() {
    bool isValid = false;
    bool isValidJobTitle = false;
    bool isValidExpTime = false;
    if (jobTitle != null && jobTitle!.isNotEmpty) {
      errors.remove("jobTitle");
      isValidJobTitle = true;
    } else {
      errors.addAll({"jobTitle": "Vui lòng nhập tên công việc đã thực hiện"});
      stateController.sink.addError(errors);
    }
    if (expTime != null && expTime!.isNotEmpty) {
      errors.remove("expTime");
      isValidExpTime = true;
    } else {
      errors.addAll(
          {"expTime": "Vui lòng nhập thời gian bạn đã làm công việc này"});
      stateController.sink.addError(errors);
    }
    if (isValidJobTitle && isValidExpTime) {
      isValid = true;
      stateController.sink.add(OtherWorkExperienceState());
    }
    return isValid;
  }

  Future<void> addNewWorkExperience(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/work-exp/mobile/add");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "name": jobTitle,
            "expTime": expTime,
            "description": (description != null) ? description : "",
            "sitterId": globals.sitterID,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        if (globals.sitterStatus == "CREATED" || globals.sitterStatus == "REJECTED") {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          showSuccessDialogForCreated(
              context, "Thêm kinh nghiệm làm việc thành công");
        } else {
          // ignore: use_build_context_synchronously
          showSuccessDialog(context, "Thêm kinh nghiệm làm việc thành công",
              "/workExperienceScreen");
        }
        ;
      } else {
        // ignore: avoid_print
        print(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> updateWorkExperience(
      BuildContext context, String workExperienceID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/work-exp/mobile/update");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "id": workExperienceID,
            "name": jobTitle,
            "expTime": expTime,
            "description": (description != null) ? description : "",
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        showSuccessDialog(context, "Cập nhật kinh nghiệm làm việc thành công",
            "/workExperienceScreen");
      } else {
        // ignore: avoid_print
        print(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> getAllWorkExperience() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/work-exp/mobile/all-work-exp/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllWorkExperienceState(
            workExperienceList:
                WorkExperienceAllModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch work experience from the REST API');
      }
    } finally {}
  }

  Future<void> getWorkExperienceByID(String workExperienceID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/work-exp/mobile/work-exp/$workExperienceID");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      //print("test status code getWorkExperienceByID ${response.statusCode}");
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetWorkExperienceDetailState(
            workExperience: WorkExperienceDetailModel.fromJson(
                json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch elder from the REST API');
      }
    } finally {}
  }

  Future<void> deleteWorkExperience(
      BuildContext context, String workExperienceID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/work-exp/mobile/remove/$workExperienceID");
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

        showSuccessDialog(context, "Xóa thành công", '/workExperienceScreen');
      } else {
        // ignore: avoid_print
        print(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
}
