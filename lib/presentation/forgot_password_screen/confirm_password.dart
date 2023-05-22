import 'package:elssit/presentation/forgot_password_screen/add_new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/color_constant.dart';

class ForgotPasswordConfirmPasscodeScreen extends StatefulWidget {
  const ForgotPasswordConfirmPasscodeScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordConfirmPasscodeScreen> createState() =>
      _ForgotPasswordConfirmPasscodeScreenState();
}

class _ForgotPasswordConfirmPasscodeScreenState
    extends State<ForgotPasswordConfirmPasscodeScreen> {
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
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.3,
                  ),
                  child: Text(
                    'Mã xác thực đã được gửi đến số điện thoại',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: size.height * 0.02,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.06,
                  ),
                  child: StreamBuilder(
                    stream: null,
                    builder: (context, snapshot) => Theme(
                        data: theme.copyWith(
                          colorScheme: theme.colorScheme
                              .copyWith(primary: ColorConstant.primaryColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.height * 0.085,
                              height: size.height * 0.07,
                              child: TextField(
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    color: Colors.black),
                                cursorColor: ColorConstant.primaryColor,
                                controller: null,
                                textAlign: TextAlign.center,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffEEEEEE), width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(11)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(11)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: ColorConstant.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.035,
                            ),
                            SizedBox(
                              width: size.height * 0.085,
                              height: size.height * 0.07,
                              child: TextField(
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    color: Colors.black),
                                cursorColor: ColorConstant.primaryColor,
                                textInputAction: TextInputAction.next,
                                textAlign: TextAlign.center,
                                controller: null,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffEEEEEE), width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(11)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(11)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: ColorConstant.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.035,
                            ),
                            SizedBox(
                              width: size.height * 0.085,
                              height: size.height * 0.07,
                              child: TextField(
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    color: Colors.black),
                                cursorColor: ColorConstant.primaryColor,
                                textInputAction: TextInputAction.next,
                                textAlign: TextAlign.center,
                                controller: null,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffEEEEEE), width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(11)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(11)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: ColorConstant.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.035,
                            ),
                            SizedBox(
                              width: size.height * 0.085,
                              height: size.height * 0.07,
                              child: TextField(
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    color: Colors.black),
                                cursorColor: ColorConstant.primaryColor,
                                textAlign: TextAlign.center,
                                controller: null,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffEEEEEE), width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(11)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(11)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: ColorConstant.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.06,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: size.height * 0.065,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordAddNewPasswordScreen(),
                            ));
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
                      child: const Text("Xác minh"),
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
}
