import 'package:elssit/core/utils/image_constant.dart';
import 'package:elssit/core/utils/color_constant.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'confirm_password.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                  ImageConstant.forgot_password_img,
                  width: size.width,
                  height: size.height * 0.4,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.03,
                    bottom: size.height * 0.01,
                  ),
                  child: Text(
                    'Vui lòng nhập số điện thoại đã đăng ký',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: size.height * 0.022,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.03,
                  ),
                  padding: EdgeInsets.only(
                    top: size.height * 0.03,
                    bottom: size.height * 0.03,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: ColorConstant.primaryColor,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.03,
                      right: size.width * 0.03,
                    ),
                    child: StreamBuilder(
                      stream: null,
                      builder: (context, snapshot) => Theme(
                        data: theme.copyWith(
                          colorScheme: theme.colorScheme
                              .copyWith(primary: ColorConstant.primaryColor),
                        ),
                        child: TextField(
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            color: Colors.black,
                          ),
                          cursorHeight: size.height * 0.03,
                          cursorColor: ColorConstant.primaryColor,
                          controller: null,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Số điện thoại",
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            prefixIcon: SizedBox(
                              width: size.width * 0.3,
                              child: Image.asset(
                                ImageConstant.ic_message,
                                alignment: Alignment.center,
                                width: size.width * 0.5,
                                height: size.height * 0.1,
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.04,
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
                                  const ForgotPasswordConfirmPasscodeScreen(),
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
                      child: const Text("Tiếp tục"),
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
