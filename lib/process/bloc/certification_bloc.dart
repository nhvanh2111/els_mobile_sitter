import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:elssit/core/models/certification_models/certification_all_model.dart';
import 'package:elssit/core/models/certification_models/certification_detail_model.dart';
import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/utils/globals.dart' as globals;
import '../../core/validators/validations.dart';
import 'package:elssit/core/utils/my_utils.dart';

import 'package:elssit/process/event/certification_event.dart';
import 'package:elssit/process/state/certification_state.dart';

import '../../presentation/widget/dialog/success_dialog.dart';
import '../../presentation/widget/dialog/success_dialog_for_created.dart';

class CertificationBloc {
  final eventController = StreamController<CertificationEvent>();

  final stateController = StreamController<CertificationState>();

  final Map<String, String> errors = HashMap();

  String? dateReceived;
  String? title;
  String? organization;
  String? credentialID;
  String? credentialURL;
  String? certificationImg;

  //bool? isExpired;

  CertificationBloc() {
    eventController.stream.listen((event) {
      if (event is ChooseReceivedDateCertificationEvent) {
        dateReceived = event.receivedDate;
        stateController.sink.add(DateReceivedCertificationState(
            dateReceivedController: TextEditingController(
                text: MyUtils().convertInputDate(event.receivedDate))));
      }
      if (event is FillTitleCertificationEvent) {
        title = event.title;
      }
      if (event is FillOrganizationCertificationEvent) {
        organization = event.organization;
      }
      if (event is FillCredentialIDCertificationEvent) {
        credentialID = event.credentialID;
      }
      if (event is FillCredentialURLCertificationEvent) {
        credentialURL = event.credentialURL;
      }
      if (event is CertificationImgEvent) {
        certificationImg = event.certificationImg;
      }
      if (event is AddNewCertificationEvent) {
        if (certificationValidation()) {
          addNewCertification(event.context);
        } else {
          print('Lỗi nè');
        }
      }
      if (event is GetAllCertificationEvent) {
        getAllCertification();
      }
      if (event is GetCertificationDetailDataEvent) {
        getCertificationByID(event.certificationID);
      }
      if (event is UpdateCertificationEvent) {
        if (certificationValidation()) {
          updateCertification(event.context, event.certificationID);
        }
      }
      if (event is DeleteCertificationEvent) {
        deleteCertification(event.context, event.certificationID);
      }
    });
  }

  bool certificationValidation() {
    bool isValid = false;
    bool isValidTitle = false;
    bool isValidOrganization = false;
    bool isValidTime = false;
    bool isValidCertificationImg = false;
    bool isValidCertificationID = false;
    if (title != null && title!.isNotEmpty) {
      errors.remove("title");
      isValidTitle = true;
    } else {
      errors.addAll({"title": "Vui lòng nhập tiêu đề của chứng nhận"});
      stateController.sink.addError(errors);
    }
    if (organization != null && organization!.isNotEmpty) {
      errors.remove("organization");
      isValidOrganization = true;
    } else {
      errors.addAll({"organization": "Vui lòng nhập đơn vị cấp chứng nhận"});
      stateController.sink.addError(errors);
    }
    if (credentialID != null && credentialID!.isNotEmpty) {
      errors.remove("credentialID");
      isValidCertificationID = true;
    } else {
      errors.addAll({"credentialID": "Vui lòng nhập ID xác thực"});
      stateController.sink.addError(errors);
    }
    if (dateReceived != null && dateReceived!.isNotEmpty) {
      if (Validations.isValidCertificationTime(dateReceived)) {
        errors.remove("time");
        isValidTime = true;
      } else {
        errors.addAll({"time": "Thời gian không hợp lệ"});
        stateController.sink.addError(errors);
      }
    } else {
      errors.addAll({"time": "Thời gian không hợp lệ"});
      stateController.sink.addError(errors);
    }
    if (certificationImg != null) {
      isValidCertificationImg = true;
      errors.remove("certificationImg");
    } else {
      errors.addAll({"certificationImg": "Vui lòng tải lên chứng chỉ"});
    }
    if (isValidCertificationImg &&
        isValidTitle &&
        isValidOrganization &&
        isValidTime &&
        isValidCertificationID) {
      isValid = true;
      stateController.sink.add(OtherCertificationState());
    }
    return isValid;
  }

  Future<void> addNewCertification(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/certificate/mobile/create");

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "sitterId": globals.sitterID,
            "certificateDTOList": [
              {
                "title": title,
                "organization": organization,
                "dateReceived": MyUtils().convertInputDate(dateReceived!),
                "credentialID": credentialID,
                "credentialURL": credentialURL,
                "certificateImgUrl": certificationImg,
              }
            ]
          },
        ),
      );
      print('Test status code updateCertification: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        if (globals.sitterStatus == "CREATED" || globals.sitterStatus == "REJECTED") {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          showSuccessDialogForCreated(context, "Thêm chứng chỉ thành công");
          eventController.sink.add(GetAllCertificationEvent());
        } else {
          // ignore: use_build_context_synchronously
          showSuccessDialog(
              context, "Thêm chứng chỉ thành công", "/certificationScreen");
        }
      } else {
        // ignore: avoid_print
        print(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> updateCertification(
      BuildContext context, String certificationID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/certificate/mobile/update");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "id": certificationID,
            "title": title,
            "organization": organization,
            "dateReceived": MyUtils().convertInputDate(dateReceived!),
            "credentialID": (credentialID != null) ? credentialID : "",
            "credentialURL": (credentialURL != null) ? credentialURL : "",
            "certificateImgUrl": certificationImg,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        if (globals.sitterStatus == "CREATED" || globals.sitterStatus == "REJECTED") {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          showSuccessDialogForCreated(context, "Sửa chứng chỉ thành công");
          getAllCertification();
        } else {
          // ignore: use_build_context_synchronously
          showSuccessDialog(
              context, "Sửa chứng chỉ thành công", "/certificationScreen");
        }
      } else {
        // ignore: avoid_print
        print(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> getCertificationByID(String certificationID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/certificate/common/$certificationID");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(CertificationDetailState(
            certification:
                CertificationDetailModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch cus from the REST API');
      }
    } finally {}
  }

  Future<void> getAllCertification() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/certificate/common/all/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      print('Test status code getAllCertification ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        print('Vô nè');
        stateController.sink.add(GetAllCertificationState(
            certificationList:
                CertificationAllModel.fromJson(json.decode(response.body))));
      } else if (response.statusCode.toString() == '404') {
        // throw Exception('Unable to fetch elder from the REST API');
        stateController.sink.add(GetAllNullCertificationState());
      } else {
        // throw Exception('Unable to fetch elder from the REST API');
        print(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> deleteCertification(
      BuildContext context, String certificationID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/certificate/mobile/remove/$certificationID");
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
        Navigator.pushNamed(context, '/certificationScreen');
      } else {
        // ignore: avoid_print
        print(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
}
