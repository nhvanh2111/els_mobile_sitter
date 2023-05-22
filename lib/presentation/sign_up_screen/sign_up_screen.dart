import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/core/utils/image_constant.dart';

import 'package:elssit/process/bloc/sitter_bloc.dart';
import 'package:elssit/process/event/sitter_event.dart';
import 'package:elssit/process/state/sitter_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _showPass = false;
  final _sitBloc = SitBloc();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return StreamBuilder<SitState>(
      stream: _sitBloc.stateController.stream,
      builder: (context, snapshot) {
        return Material(
          child: Container(
            width: size.width,
            height: size.height,
            padding: EdgeInsets.only(
              left: size.width * 0.07,
              right: size.width * 0.07,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Image.asset(ImageConstant.appLogo,
                      height: size.height * 0.15, width: size.width * 0.3),
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.02),
                  ),
                  Text(
                    'Tạo Tài Khoản Mới',
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     top: size.height * 0.06,
                  //   ),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.03,
                      bottom: size.height * 0.01,
                      // left: size.height * 0.04,
                      // right: size.height * 0.04,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.grayED,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Theme(
                      data: theme.copyWith(
                        colorScheme: theme.colorScheme
                            .copyWith(primary: ColorConstant.primaryColor),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          _sitBloc.eventController.sink
                              .add(FillEmailSitEvent(email: value.toString()));
                        },
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        cursorColor: ColorConstant.primaryColor,
                        controller: null,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: SizedBox(
                            width: size.width * 0.05,
                            child: Icon(
                              Icons.account_circle_sharp,
                              size: size.width * 0.05,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  (snapshot.hasError &&
                          (snapshot.error as Map<String, String>)
                              .containsKey("email"))
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (snapshot.error as Map<String, String>)["email"]!,
                            style: TextStyle(
                              color: ColorConstant.redFail,
                              fontSize: size.height * 0.017,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     top: size.height * 0.02,
                  //   ),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.02,
                      bottom: size.height * 0.01,
                      // left: size.height * 0.04,
                      // right: size.height * 0.04,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.grayED,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Theme(
                      data: theme.copyWith(
                        colorScheme: theme.colorScheme
                            .copyWith(primary: ColorConstant.primaryColor),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          _sitBloc.eventController.sink
                              .add(FillPhoneSitEvent(phone: value.toString()));
                        },
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        cursorColor: ColorConstant.primaryColor,
                        controller: null,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Số điện thoại",
                          // errorText: snapshot.hasError
                          //     ? snapshot.error.toString()
                          //     : null,
                          prefixIcon: SizedBox(
                            width: size.width * 0.05,
                            child: Icon(
                              Icons.phone,
                              size: size.width * 0.05,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  (snapshot.hasError &&
                          (snapshot.error as Map<String, String>)
                              .containsKey("phone"))
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (snapshot.error as Map<String, String>)["phone"]!,
                            style: TextStyle(
                              color: ColorConstant.redFail,
                              fontSize: size.height * 0.017,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     top: size.height * 0.02,
                  //   ),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.02,
                      bottom: size.height * 0.01,
                      // left: size.height * 0.04,
                      // right: size.height * 0.04,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.grayED,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        Theme(
                          data: theme.copyWith(
                            colorScheme: theme.colorScheme
                                .copyWith(primary: ColorConstant.primaryColor),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              _sitBloc.eventController.sink.add(
                                  FillPasswordSitEvent(
                                      password: value.toString()));
                            },
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            obscureText: !_showPass,
                            cursorColor: ColorConstant.primaryColor,
                            controller: null,
                            decoration: InputDecoration(
                              // errorText: snapshot.hasError
                              //     ? snapshot.error.toString()
                              //     : null,
                              hintText: "Mật Khẩu",
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ),
                          ),
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
                  ),
                  (snapshot.hasError &&
                          (snapshot.error as Map<String, String>)
                              .containsKey("password"))
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (snapshot.error
                                as Map<String, String>)["password"]!,
                            style: TextStyle(
                              color: ColorConstant.redFail,
                              fontSize: size.height * 0.017,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     top: size.height * 0.02,
                  //   ),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.02,
                      bottom: size.height * 0.01,
                      // left: size.height * 0.04,
                      // right: size.height * 0.04,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.grayED,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        Theme(
                          data: theme.copyWith(
                            colorScheme: theme.colorScheme
                                .copyWith(primary: ColorConstant.primaryColor),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              _sitBloc.eventController.sink.add(
                                  FillRePasswordSitEvent(
                                      rePassword: value.toString()));
                            },
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            obscureText: !_showPass,
                            cursorColor: ColorConstant.primaryColor,
                            controller: null,
                            decoration: InputDecoration(
                              // errorText: snapshot.hasError
                              //     ? snapshot.error.toString()
                              //     : null,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ),
                          ),
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
                  ),
                  (snapshot.hasError &&
                          (snapshot.error as Map<String, String>)
                              .containsKey("rePassword"))
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (snapshot.error
                                as Map<String, String>)["rePassword"]!,
                            style: TextStyle(
                              color: ColorConstant.redFail,
                              fontSize: size.height * 0.017,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.05,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          _sitBloc.eventController.sink
                              .add(SignUpSitEvent(context: context));
                        },
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
                        child: const Text("Đăng ký"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.04,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                            color: ColorConstant.grayA3,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.05,
                              right: size.width * 0.05),
                          child: Text(
                            "Hoặc ",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: ColorConstant.gray75,
                              fontSize: size.height * 0.018,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                            color: ColorConstant.grayA3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.04,
                    ),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: ColorConstant.whiteEE),
                          ),
                          backgroundColor: Colors.white,
                          textStyle: TextStyle(
                            fontSize: size.width * 0.045,
                          ),
                          elevation: 1,
                          shadowColor: Colors.grey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(ImageConstant.imgGoogle,
                                width: size.height * 0.04),
                            Text(
                              '    Đăng nhập với Google',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          // setState(() {
                          //   final provider = Provider.of<GoogleSignInProvider>(
                          //       context,
                          //       listen: false);
                          //   provider.googleLogin();
                          // });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.04,
                      bottom: size.height * 0.02,
                    ),
                    child: SizedBox(
                      width: size.width,
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Đã có tài khoản? ',
                              style: GoogleFonts.roboto(
                                color: ColorConstant.grayAE,
                                fontSize: size.height * 0.017,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context, '/loginWithGoogleNav');
                              },
                              child: Text(
                                'Đăng nhập',
                                style: GoogleFonts.roboto(
                                  color: ColorConstant.primaryColor,
                                  fontSize: size.height * 0.018,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.2,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
