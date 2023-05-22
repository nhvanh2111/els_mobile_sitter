import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';

class ForgotPasswordAddNewPasswordScreen extends StatefulWidget {
  const ForgotPasswordAddNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordAddNewPasswordScreen> createState() =>
      _ForgotPasswordAddNewPasswordScreenState();
}

class _ForgotPasswordAddNewPasswordScreenState
    extends State<ForgotPasswordAddNewPasswordScreen> {
  bool _showPass = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
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
              Icons.arrow_back_rounded,
              size: size.height * 0.03,
              color: Colors.black,
            ),
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
                  ImageConstant.add_new_password_img,
                  width: size.width,
                  height: size.height * 0.4,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.03,
                    bottom: size.height * 0.03,
                  ),
                  child: Text(
                    'Vui lòng nhập mật khẩu mới',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: size.height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteFA,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: StreamBuilder(
                          stream: null,
                          builder: ((context, snapshot) => Theme(
                                data: theme.copyWith(
                                  colorScheme: theme.colorScheme.copyWith(
                                      primary: ColorConstant.primaryColor),
                                ),
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  obscureText: !_showPass,
                                  cursorColor: ColorConstant.primaryColor,
                                  controller: null,
                                  decoration: InputDecoration(
                                    errorText: snapshot.hasError
                                        ? snapshot.error.toString()
                                        : null,
                                    hintText: "Mật khẩu mới",
                                    prefixIcon: SizedBox(
                                      width: size.width * 0.05,
                                      child: Icon(
                                        Icons.lock,
                                        size: size.width * 0.05,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        // borderSide: BorderSide(
                                        //     color: Color(0xffCED0D2), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: ColorConstant.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: size.height * 0.02,
                          right: size.height * 0.02),
                      child: GestureDetector(
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
                    ),
                  ],
                ),
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteFA,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: StreamBuilder(
                          stream: null,
                          builder: ((context, snapshot) => Theme(
                                data: theme.copyWith(
                                  colorScheme: theme.colorScheme.copyWith(
                                      primary: ColorConstant.primaryColor),
                                ),
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  obscureText: !_showPass,
                                  cursorColor: ColorConstant.primaryColor,
                                  controller: null,
                                  decoration: InputDecoration(
                                    errorText: snapshot.hasError
                                        ? snapshot.error.toString()
                                        : null,
                                    hintText: "Nhập lại mật khẩu",
                                    prefixIcon: SizedBox(
                                      width: size.width * 0.05,
                                      child: Icon(
                                        Icons.lock,
                                        size: size.width * 0.05,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: ColorConstant.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.height * 0.02),
                      child: GestureDetector(
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
                    ),
                  ],
                ),
                //),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.05,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: size.height * 0.065,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: ColorConstant.primaryColor),
                        ),
                        backgroundColor: ColorConstant.primaryColor,
                        textStyle: TextStyle(
                          fontSize: size.width * 0.045,
                        ),
                      ),
                      child: const Text("Hoàn thành"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
