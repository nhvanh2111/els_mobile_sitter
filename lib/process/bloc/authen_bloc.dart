// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'package:elssit/presentation/widget/dialog/forward_dialog.dart';
import 'package:elssit/presentation/widget/dialog/success_dialog.dart';
import 'package:elssit/presentation/widget/dialog/waring_reject_dialog.dart';
import 'package:elssit/presentation/widget/dialog/warning_reject_in_app_dialog.dart';
import 'package:elssit/process/event/authen_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:elssit/core/validators/validations.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import '../../core/models/identify_information_models/identify_information_model.dart';
import '../../core/utils/globals.dart' as globals;
import '../../fire_base/provider/google_sign_in_provider.dart';
import '../../presentation/widget/dialog/fail_dialog.dart';
import '../state/authen_state.dart';

class AuthenBloc {
  final eventController = StreamController<AuthenEvent>();

  final stateController = StreamController<AuthenState>();

  final Map<String, String> error = HashMap();
  String? email;
  String? password;
  String? rePassword;
  String? oldPassword;
  late Timer? timer;
  AuthenBloc() {
    eventController.stream.listen((AuthenEvent event) async {
      if (event is LoginEvent) {
        if (loginValidate()) {
          loginWithAccount(event.context);
        } else {}
      } else if (event is InputEmailEvent) {
        email = event.email;
      } else if (event is InputPasswordEvent) {
        password = event.password;
      } else if (event is InputRePasswordEvent) {
        rePassword = event.rePassword;
      } else if (event is InputOldPasswordEvent) {
        oldPassword = event.oldPassword;
      } else if (event is LogoutEvent) {
        logout(event.context);
      } else if (event is LoginWithGoogle) {
        loginWithGoogle(event.context, event.email, event.fullName, event.gender, event.dob, event.token);
      } else if (event is MaintainLoginEvent) {
        final elsBox = Hive.box('elsBox');
        email = elsBox.get('email');
        password = elsBox.get('password');
        loginWithAccount(event.context);
      }  else if (event is ChangePasswordAuthenEvent) {
        if (changePasswordValidate()) {
          changePassword(event.context);
        } else {}
      } else if (event is LoadInfo) {
        try {
          await loadingInformation(event.context);
        } catch (e) {
          print("e exception - ${e}" );
        }

      } else {
        if (kDebugMode) {
          print("AuthenBloc do nothing");
        }
      }
    });
  }
  bool changePasswordValidate() {
    bool isValid = false;
    bool isValidOldPassword = false;
    bool isValidNewPassword = false;
    bool isValidRePassword = false;
    if (oldPassword != null && oldPassword!.isNotEmpty) {
      if (Validations.isValidPassword(oldPassword!)) {
        error.remove("oldPassword");
        isValidOldPassword = true;
      } else {
        error.addAll({
          "oldPassword":
          "Mật khẩu phải có tối thiểu 8 ký tự bao gồm chữ thường chữ in hoa và số"
        });
      }
    } else {
      error.addAll({"oldPassword": "Vui lòng nhập mật khẩu hiện tại"});
    }
    if (password != null && password!.isNotEmpty) {
      if (Validations.isValidPassword(password!)) {
        error.remove("newPassword");
        isValidNewPassword = true;
      } else {
        error.addAll({
          "newPassword":
          "Mật khẩu phải có tối thiểu 8 ký tự bao gồm chữ thường chữ in hoa và số"
        });
      }
    } else {
      error.addAll({"newPassword": "Vui lòng nhập mật khẩu mới"});
    }
    if (rePassword != null && rePassword!.isNotEmpty) {
      if (rePassword == password) {
        error.remove("rePassword");
        isValidRePassword = true;
      } else {
        error.addAll({"rePassword": "Mật khẩu không trùng khớp"});
      }
    } else {
      error.addAll({"rePassword": "Vui lòng nhập lại mật khẩu"});
    }
    stateController.sink.addError(error);
    if (isValidOldPassword && isValidNewPassword && isValidRePassword) {
      isValid = true;
      stateController.sink.add(OtherAuthenState());
    }
    return isValid;
  }
  bool loginValidate() {
    bool isValid = false;
    bool isValidEmail = false;
    bool isValidPassword = false;
    if (email == null || email!.trim().isEmpty) {
      error.addAll({"email": "Vui lòng điền email"});
    } else {
      if (Validations.isValidEmail(email!)) {
        error.remove("email");
        isValidEmail = true;
      } else {
        error.addAll({"email": "Vui lòng nhập đúng định dạng email"});
      }
    }
    if (password == null || password!.trim().isEmpty) {
      error.addAll({"password": "Vui lòng điền mật khẩu"});
    } else {
      if (Validations.isValidPassword(password!)) {
        error.remove("password");
        isValidPassword = true;
      } else {
        error.addAll({
          "password":
              "Mật khẩu phải có tối thiểu 8 ký tự Bao gồm chữ In chữ thường và số"
        });
      }
    }
    if (isValidEmail && isValidPassword) {
      isValid = true;
      stateController.sink.add(OtherAuthenState());
    } else {
      stateController.sink.addError(error);
    }
    return isValid;
  }

  Future<void> loginWithAccount(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/common/auth/login");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'email': email!,
            'password': password!,
            'token': globals.deviceID,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        globals.bearerToken =
            json.decode(response.body)["data"]["token"].toString();
        if (Jwt.parseJwt(globals.bearerToken.split(" ")[1])["authorities"][0]
                    ["authority"]
                .toString() ==
            "SITTER") {
          globals.sitterID =
              Jwt.parseJwt(globals.bearerToken.split(" ")[1])["id"].toString();
          globals.email =
              Jwt.parseJwt(globals.bearerToken.split(" ")[1])["sub"].toString();
          if (Jwt.parseJwt(globals.bearerToken.split(" ")[1])["status"]
                  .toString() ==
              "CREATED") {
            final elsBox = Hive.box('elsBox');
            elsBox.put('checkLogin', true);
            elsBox.put('email', email!);
            elsBox.put('password', password);
            globals.email = email!;
            globals.sitterStatus =
                Jwt.parseJwt(globals.bearerToken.split(" ")[1])["status"];
            showForwardDialog(context);
          }else if (Jwt.parseJwt(globals.bearerToken.split(" ")[1])["status"]
              .toString() ==
              "REJECTED") {
            final elsBox = Hive.box('elsBox');
            elsBox.put('checkLogin', true);
            elsBox.put('email', email!);
            elsBox.put('password', password);
            globals.email = email!;
            globals.sitterStatus =
            Jwt.parseJwt(globals.bearerToken.split(" ")[1])["status"];
            showWarningRejectDialog(context);
          } else {
            final elsBox = Hive.box('elsBox');
            elsBox.put('checkLogin', true);
            elsBox.put('email', email!);
            elsBox.put('password', password);
            globals.email = email!;
            globals.sitterStatus =
                Jwt.parseJwt(globals.bearerToken.split(" ")[1])["status"];
            Navigator.pushNamed(context, '/homeScreen');
          }
        } else {
          showFailDialog(
              context, "Tài khoản đã được đăng ký dưới vai trò khác");
        }
      } else {
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
  Future<void> changePassword(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/common/auth/change-password");
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "email": globals.email,
            "oldPassword": oldPassword!,
            "newPassword": password!,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        showSuccessDialog(context, "Đổi mật khẩu thành công", "/accountScreen");
        final elsBox = Hive.box('elsBox');
        elsBox.put('password', password);
      } else {
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
  Future<void> loginWithGoogle(BuildContext context, String email,
      String fullName, String dob, String gender, String token) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/common/auth/login-sitter-gmail");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "email": email,
            "fullName": fullName,
            "dob": dob,
            "gender": gender,
            "token": token
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        globals.bearerToken =
            json.decode(response.body)["data"]["token"].toString();
        if (Jwt.parseJwt(globals.bearerToken.split(" ")[1])["authorities"][0]
        ["authority"]
            .toString() ==
            "SITTER") {


          if (Jwt.parseJwt(globals.bearerToken.split(" ")[1])["status"]
              .toString() ==
              "CREATED") {
            globals.sitterID =
                Jwt.parseJwt(globals.bearerToken.split(" ")[1])["id"].toString();
            globals.email = email;

            globals.sitterStatus =
            Jwt.parseJwt(globals.bearerToken.split(" ")[1])["status"];
            showForwardDialog(context);
          } else {
            final elsBox = Hive.box('elsBox');
            globals.sitterID =
                Jwt.parseJwt(globals.bearerToken.split(" ")[1])["id"].toString();
            globals.email = email;

            globals.sitterStatus =
            Jwt.parseJwt(globals.bearerToken.split(" ")[1])["status"];
            Navigator.pushNamed(context, '/homeScreen');
          }
        } else {
          showFailDialog(
              context, "Tài khoản đã được đăng ký dưới vai trò khác");
        }
      } else {
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<IdentifyInformationModel> loadingInformation(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/sitter/mobile/information/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
      );
      if (response.statusCode.toString() == '200') {
        globals.identifyInformation =
            IdentifyInformationModel.fromJson(json.decode(response.body)).data;
        globals.sitterStatus = globals.identifyInformation!.status;
        print('Test fetch load data ${globals.sitterStatus}');
        if(globals.sitterStatus == "REJECTED"){
          timer!.cancel();
          // final elsBox = Hive.box('elsBox');
          // final provider = Provider.of<GoogleSignInProvider>(context,
          //     listen: false);
          // provider.logout();
          // elsBox.delete('checkLogin');
          // elsBox.delete('email');
          // elsBox.delete('password');
          // logout(context);
          showWarningRejectDialog(context);
        }
        stateController.sink.add(OtherAuthenState());
        stateController.sink.add(LoadDataState());
        return IdentifyInformationModel.fromJson(json.decode(response.body));
      } else {
        throw Exception("Unable to fetch loadingInformation");
      }
    } finally {}
  }

  Future<void> logout(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/common/auth/logout/${globals.email}");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{},
        ),
      );
      if (response.statusCode.toString() == '200') {
        Navigator.pushNamed(context, '/loginWithGoogleNav');

      } else {
        if (kDebugMode) {
          print('Đăng xuất thất bại');
        }
      }
    } finally {}
  }
}
