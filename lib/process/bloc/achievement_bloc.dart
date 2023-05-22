import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:elssit/core/models/achievement_models/achievement_all_model.dart';
import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/utils/globals.dart' as globals;
import '../../core/validators/validations.dart';
import 'package:elssit/core/utils/my_utils.dart';

import 'package:elssit/process/event/achievement_event.dart';
import 'package:elssit/process/state/achievement_state.dart';

import 'package:elssit/core/models/achievement_models/achievement_detail_data_model.dart';
import 'package:elssit/core/models/achievement_models/achievement_detail_model.dart';

class AchievementBloc {
  final eventController = StreamController<AchievementEvent>();

  final stateController = StreamController<AchievementState>();

  final Map<String, String> errors = HashMap();

  String? dateReceived;
  String? title;
  String? organization;
  String? description;
  String? achievementImg;

  AchievementBloc() {
    eventController.stream.listen((event) {
      if (event is ChooseReceivedDateAchievementEvent) {
        dateReceived = event.receivedDate;
        stateController.sink.add(DateReceivedAchievementState(
            dateReceivedController: TextEditingController(
                text: MyUtils().convertInputDate(event.receivedDate))));
      }
      if (event is FillTitleAchievementEvent) {
        title = event.title;
      }
      if (event is FillOrganizationAchievementEvent) {
        organization = event.organization;
      }
      if (event is FillDescriptionAchievementEvent) {
        description = event.description;
      }
      if (event is AchievementImgEvent) {
        achievementImg = event.achievementImg;
      }
      if (event is AddNewAchievementEvent) {
        if (achievementValidation()) {
          addNewAchievement(event.context);
        }
      }
      if (event is GetAllAchievementEvent) {
        getAllAchievement();
      }
      if (event is GetAchievementDetailDataEvent) {
        getAchievementByID(event.achievementID);
      }
      if (event is UpdateAchievementEvent) {
        if (achievementValidation()) {
          updateAchievement(event.context, event.achievementID);
        }
      }
    });
  }

  bool achievementValidation() {
    bool isValid = false;
    bool isValidTitle = false;
    bool isValidOrganization = false;
    bool isValidAchievementImg = false;
    if (title != null && title!.isNotEmpty) {
      errors.remove("title");
      isValidTitle = true;
    } else {
      errors.addAll({"title": "Vui lòng nhập tiêu đề của giải thưởng"});
      stateController.sink.addError(errors);
    }
    if (organization != null && organization!.isNotEmpty) {
      errors.remove("organization");
      isValidOrganization = true;
    } else {
      errors.addAll({"organization": "Vui lòng nhập đơn vị cấp giải thưởng"});
      stateController.sink.addError(errors);
    }
    if (achievementImg != null) {
      isValidAchievementImg = true;
      errors.remove("achievementImg");
    } else {
      errors.addAll({"achievementImg": "Vui lòng tải lên chứng chỉ"});
    }
    if (isValidAchievementImg && isValidTitle && isValidOrganization) {
      isValid = true;
      stateController.sink.add(OtherAchievementState());
    }
    return isValid;
  }

  Future<void> addNewAchievement(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/achievement/mobile/create");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "title": title,
            "organization": organization,
            "dateReceived": MyUtils().convertInputDate(dateReceived!),
            "description": (description != null) ? description : "",
            "achievementImg": achievementImg,
            "sitterId": globals.sitterID,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/achievementScreen');
      } else {
        // ignore: avoid_print
        print(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> getAchievementByID(String achievementID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/achievement/common/$achievementID");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(AchievementDetailState(
            achievement:
                AchievementDetailModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch cus from the REST API');
      }
    } finally {}
  }

  Future<void> getAllAchievement() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/achievement/common/all/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllAchievementState(
            achievementList:
                AchievementAllModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch elder from the REST API');
      }
    } finally {}
  }

  Future<void> updateAchievement(
      BuildContext context, String achievementID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/achievement/mobile/update");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "id": achievementID,
            "title": title,
            "organization": organization,
            "dateReceived": MyUtils().convertInputDate(dateReceived!),
            "description": (description != null) ? description : "",
            "achievementImg": achievementImg,
          },
        ),
      );

      // if (response.statusCode.toString() == '200') {
      //   // ignore: use_build_context_synchronously
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const SuccessScreen(
      //             content: "Thay đổi thông tin người thân mới thành công",
      //             buttonName: "Quản lý người thân",
      //             navigatorPath: '/elderScreen'),
      //       ));
      // } else {
      //   // ignore: use_build_context_synchronously
      //   showFailDialog(
      //       context, json.decode(response.body)["message"].toString());
      // }
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/achievementScreen');
      } else {
        // ignore: avoid_print
        print(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
}
