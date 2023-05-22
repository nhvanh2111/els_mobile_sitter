
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../process/bloc/authen_bloc.dart';
import '../../process/event/authen_event.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key, r}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() =>
      // ignore: no_logic_in_create_state
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _showPass = false;
  final _authenBloc = AuthenBloc();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return StreamBuilder<Object>(
        stream: _authenBloc.stateController.stream,
        builder: (context, snapshot) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                bottomOpacity: 0.0,
                elevation: 0.0,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: size.height * 0.03,
                    color: Colors.black,
                  ),
                ),
                title: const Text(
                  "Tạo & Đổi Mật khẩu",
                ),
                titleTextStyle: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: size.height * 0.026,
                  fontWeight: FontWeight.bold,
                ),
              ),
              body: Container(
                height: size.height,
                width: size.width,
                padding: EdgeInsets.only(
                  left: size.width * 0.07,
                  right: size.width * 0.07,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.imgResetpasswordpana,
                        width: size.width,
                        height: size.height * 0.3,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.1,
                        ),
                        child: Theme(
                          data: theme.copyWith(
                            colorScheme: theme.colorScheme
                                .copyWith(primary: ColorConstant.primaryColor),
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.black,
                            ),
                            obscureText: !_showPass,
                            onChanged: (value) {
                              _authenBloc.eventController.sink.add(
                                  InputOldPasswordEvent(
                                      oldPassword: value.toString()));
                            },
                            cursorColor: ColorConstant.primaryColor,
                            controller: null,
                            decoration: InputDecoration(
                              errorText: (snapshot.hasError &&
                                      (snapshot.error as Map<String, String>)
                                          .containsKey("oldPassword"))
                                  ? (snapshot.error
                                      as Map<String, String>)["oldPassword"]
                                  : null,
                              hintText: "Mật Khẩu Hiện tại",
                              prefixIcon: SizedBox(
                                width: size.width * 0.05,
                                child: Icon(
                                  Icons.lock,
                                  size: size.width * 0.05,
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    onToggleShowPass();
                                  });
                                },
                                child: Icon(
                                  _showPass
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.remove_red_eye_outlined,
                                  color: _showPass
                                      ? ColorConstant.primaryColor
                                      : Colors.grey,
                                  size: size.height * 0.028,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCED0D2), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                        ),
                        child: Theme(
                          data: theme.copyWith(
                            colorScheme: theme.colorScheme
                                .copyWith(primary: ColorConstant.primaryColor),
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.black,
                            ),
                            obscureText: !_showPass,
                            onChanged: (value) {
                              _authenBloc.eventController.sink.add(
                                  InputPasswordEvent(
                                      password: value.toString()));
                            },
                            cursorColor: ColorConstant.primaryColor,
                            controller: null,
                            decoration: InputDecoration(
                              hintText: "Mật Khẩu mới",
                              errorText: (snapshot.hasError &&
                                  (snapshot.error as Map<String, String>)
                                      .containsKey("newPassword"))
                                  ? (snapshot.error
                              as Map<String, String>)["newPassword"]
                                  : null,
                              prefixIcon: SizedBox(
                                width: size.width * 0.05,
                                child: Icon(
                                  Icons.lock,
                                  size: size.width * 0.05,
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    onToggleShowPass();
                                  });
                                },
                                child: Icon(
                                  _showPass
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.remove_red_eye_outlined,
                                  color: _showPass
                                      ? ColorConstant.primaryColor
                                      : Colors.grey,
                                  size: size.height * 0.028,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCED0D2), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                        ),
                        child: Theme(
                          data: theme.copyWith(
                            colorScheme: theme.colorScheme
                                .copyWith(primary: ColorConstant.primaryColor),
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.black,
                            ),
                            obscureText: !_showPass,
                            cursorColor: ColorConstant.primaryColor,
                            controller: null,
                            onChanged: (value) {
                              _authenBloc.eventController.sink.add(
                                  InputRePasswordEvent(
                                      rePassword: value.toString()));
                            },
                            decoration: InputDecoration(
                              hintText: "Nhập lại mật khẩu",
                              errorText: (snapshot.hasError &&
                                  (snapshot.error as Map<String, String>)
                                      .containsKey("rePassword"))
                                  ? (snapshot.error
                              as Map<String, String>)["rePassword"]
                                  : null,
                              prefixIcon: SizedBox(
                                width: size.width * 0.05,
                                child: Icon(
                                  Icons.lock,
                                  size: size.width * 0.05,
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    onToggleShowPass();
                                  });
                                },
                                child: Icon(
                                  _showPass
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.remove_red_eye_outlined,
                                  color: _showPass
                                      ? ColorConstant.primaryColor
                                      : Colors.grey,
                                  size: size.height * 0.028,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCED0D2), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.1,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: size.height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              _authenBloc.eventController.sink.add(
                                  ChangePasswordAuthenEvent(context: context));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.primaryColor,
                              textStyle: TextStyle(
                                fontSize: size.width * 0.045,
                              ),
                            ),
                            child: const Text("Xác nhận"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
