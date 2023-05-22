import 'package:flutter/material.dart';
import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/core/utils/image_constant.dart';

import '../../fire_base/provider/google_sign_in_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import '../../process/bloc/authen_bloc.dart';
import '../../process/event/authen_event.dart';
import '../../process/state/authen_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPass = false;
  final _authenBloc = AuthenBloc();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return StreamBuilder<AuthenState>(
        stream: _authenBloc.stateController.stream,
        builder: (context, snapshot) {
          return Container(
            color: Colors.white,
            width: size.width,
            height: size.height,
            padding: EdgeInsets.only(
              left: size.width * 0.07,
              right: size.width * 0.07,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Image.asset(ImageConstant.appLogo,
                    height: size.height * 0.15, width: size.width * 0.3),
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.01),
                ),
                Text(
                  'Đăng nhập',
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.050,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.04,
                    bottom: size.height * 0.01,
                    // left: size.height * 0.04,
                    // right: size.height * 0.04,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.whiteFA,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: ColorConstant.primaryColor,
                      controller: null,
                      onChanged: (value) {
                        _authenBloc.eventController.sink.add(
                            InputEmailEvent(email: value.toString().trim()));
                      },
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
                          borderSide:
                              //BorderSide(color: Color(0xffCED0D2), width: 1),
                              BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
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
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: size.height * 0.02,
                        bottom: size.height * 0.01,
                      ),
                      // margin: EdgeInsets.fromLTRB(size.width * 0.07, 0,
                      //     size.width * 0.07, size.height * 0.02),
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteFA,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
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
                            fontWeight: FontWeight.bold,
                          ),
                          obscureText: !_showPass,
                          onChanged: (value) {
                            _authenBloc.eventController.sink.add(
                                InputPasswordEvent(
                                    password: value.toString().trim()));
                          },
                          cursorColor: ColorConstant.primaryColor,
                          controller: null,
                          decoration: InputDecoration(
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
                                  const BorderRadius.all(Radius.circular(15)),
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
                        top: size.height * 0.01,
                        //bottom: size.height * 0.05,

                        bottom: size.height * 0.01,
                        right: size.height * 0.02,
                      ),
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
                (snapshot.hasError &&
                        (snapshot.error as Map<String, String>)
                            .containsKey("password"))
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          (snapshot.error as Map<String, String>)["password"]!,
                          style: TextStyle(
                            color: ColorConstant.redFail,
                            fontSize: size.height * 0.017,
                          ),
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.02,
                    right: size.width * 0.02,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgotPasswordScreen');
                        },
                        child: Text(
                          'Quên mật khẩu? ',
                          style: GoogleFonts.roboto(
                            color: ColorConstant.primaryColor,
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    // left: size.width * 0.07,
                    top: size.height * 0.03,
                    // right: size.width * 0.07,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: size.height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        _authenBloc.eventController.sink
                            .add(LoginEvent(context));
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
                      child: const Text("Đăng nhập"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    //left: size.width * 0.07,
                    top: size.height * 0.05,
                    //right: size.width * 0.07,
                    bottom: size.height * 0.02,
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
                            left: size.width * 0.05, right: size.width * 0.05),
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
                    top: size.height * 0.03,
                    //left: size.width * 0.07,
                    //right: size.width * 0.07,
                  ),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.06,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
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
                        //shadowColor: Colors.grey,
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
                        setState(() {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.05,
                  ),
                  child: SizedBox(
                    width: size.width,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Chưa có tài khoản? ',
                            style: GoogleFonts.roboto(
                              color: ColorConstant.grayAE,
                              fontSize: size.height * 0.017,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/signUpScreen');
                            },
                            child: Text(
                              'Đăng ký',
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
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Ứng dụng cho Chăm sóc viên',
                      style: GoogleFonts.roboto(
                        color: ColorConstant.grayAE,
                        fontSize: size.height * 0.017,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
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
