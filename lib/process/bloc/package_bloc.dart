// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:elssit/core/models/package_service_models/package_service_detail_model.dart';

import 'package:elssit/presentation/widget/dialog/comfirm_sendform_dialog.dart';
import 'package:elssit/presentation/widget/dialog/fail_dialog.dart';
import 'package:flutter/Material.dart';

import 'package:http/http.dart' as http;
import '../../core/utils/globals.dart' as globals;

import 'package:elssit/core/models/package_service_models/package_service_all_model.dart';

import 'package:elssit/process/event/package_event.dart';
import 'package:elssit/process/state/package_state.dart';

import '../../presentation/widget/dialog/comfirm_sendform_dialog.dart';

class PackageBloc {
  final eventController = StreamController<PackageEvent>();

  final stateController = StreamController<PackageState>();
  List<String>? listPackage;

  PackageBloc() {
    eventController.stream.listen((event) {
      if (event is OtherPackageEvent) {
        stateController.sink.add(OtherPackageState());
      }
      if (event is GetAllPackageEvent) {
        getAllPackage();
      }
      if (event is GetHavePackageEvent) {
        getHavePackage();
      }
      if (event is GetNotHavePackageEvent) {
        getNotHavePackage();
      }
      if (event is CheckPackageEvent) {
        if(event.packageID.isNotEmpty){
          if (listPackage == null) {
            listPackage = [];
            listPackage!.add(event.packageID);
          } else {
            if (listPackage!.contains(event.packageID)) {
              listPackage!.remove(event.packageID);
            } else {
              listPackage!.add(event.packageID);
            }
          }
        }
        stateController.sink.add(CheckPackageState(listPackage: listPackage!));
      }
      if (event is SaveListPackageEvent) {
        saveRegisPackages(event.context, event.packageBloc);
      }
      if (event is GetPackageServiceDetailEvent) {
        getPackageServiceDetail(event.packageServiceID);
      }
      if (event is ConfirmSendFormEvent) {
        confirmSendForm(event.context);
      }
    });
  }

  Future<void> getAllPackage() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/package/mobile/activate-packages");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllPackageState(
            packageList:
                PackageServiceAllModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch package from the REST API');
      }
    } finally {}
  }

  Future<void> getHavePackage() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/sitter_package/mobile/get-package-sitter-have/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      print('Test getHavePackage status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetHavePackageState(
            packageList:
                PackageServiceAllModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch have package from the REST API');
      }
    } finally {}
  }

  Future<void> getNotHavePackage() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/sitter_package/mobile/get-package-sitter-not-have/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      print('Test getNotHavePackage status: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetNotHavePackageState(
            packageList:
                PackageServiceAllModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch package from the REST API');
      }
    } finally {}
  }

  Future<void> saveRegisPackages(
      BuildContext context, PackageBloc packageBloc) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/sitter_package/mobile/add");
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
            "packageIds": List<dynamic>.from(listPackage!.map((x) => x)),
          },
        ),
      );
      print('Test respone saveRegisPackages: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        if (globals.sitterStatus == "CREATED" || globals.sitterStatus == "REJECTED") {
          confirmSendForm(context);
        } else {
          Navigator.pushNamed(context, "/accountScreen");
        }
      } else {
        throw Exception('Unable to fetch package from the REST API');
      }
    } finally {}
  }

  Future<void> confirmSendForm(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/sitter/mobile/send-form/${globals.sitterID}");
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      print('test status code confirmSendForm: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, "/homeScreen");
      } else {
        showFailDialog(context, "Cập nhật thông tin không thành công.");
      }
    } finally {}
  }

  Future<void> getPackageServiceDetail(String packageServiceID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/package/mobile/package/$packageServiceID");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetPackageServiceDetailState(
            packageDetail:
                PackageServiceDetailModel.fromJson(json.decode(response.body))
                    .data));
      } else {
        throw Exception('Unable to fetch package from the REST API');
      }
    } finally {}
  }
}
