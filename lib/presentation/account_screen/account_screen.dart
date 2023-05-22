import 'package:elssit/presentation/change_password_screen/change_password_screen.dart';
import 'package:elssit/presentation/package_screen.dart/sitter_package_screen.dart';
import 'package:elssit/presentation/report_and_rating_screen/report_and_rating_screen.dart';
import 'package:elssit/presentation/widget/status_in_account_widget.dart';

import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../fire_base/provider/google_sign_in_provider.dart';

import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/core/utils/image_constant.dart';
import 'package:elssit/core/utils/globals.dart' as globals;
import '../../process/bloc/authen_bloc.dart';
import '../../process/event/authen_event.dart';
import '../set_working_time_screen/set_working_time_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _elsBox = Hive.box('elsBox');
  final _authenBloc = AuthenBloc();

  var builde;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
        ),
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageConstant.appLogo,
                    width: size.width * 0.08,
                    height: size.width * 0.08,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    'Hồ Sơ Của Bạn',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      widthFactor: 1.0,
                      child: Icon(
                        Icons.settings_rounded,
                        size: size.height * 0.03,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.height * 0.12,
                      height: size.height * 0.12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage((globals
                                    .identifyInformation!.avatarImg.isNotEmpty)
                                ? globals.identifyInformation!.avatarImg
                                : "https://firebasestorage.googleapis.com/v0/b/elderlysitter-bc637.appspot.com/o/avatar_icon.png?alt=media&token=0907f4c5-a881-4784-b6e8-e7282f9caeba"),
                            fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          globals.identifyInformation!.fullName,
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          globals.identifyInformation!.phone,
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.gray9E,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        statusInAccountWidget(context, globals.sitterStatus),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                height: 1,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: ColorConstant.whiteEE,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/contactDetailScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_account,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Thông tin liên lạc',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/indentificationInformationScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_account,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Thông tin định danh',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/walletScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   width: size.height * 0.08,
                      //   height: size.height * 0.1,
                      //   alignment: Alignment.center,
                      //   child: Icon(
                      //     Icons.wallet,
                      //     color: ColorConstant.primaryColor,
                      //     size: size.height * 0.03,
                      //   ),
                      // ),
                      Image.asset(
                        ImageConstant.ic_payment,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Ví của bạn',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/historyScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: size.height * 0.08,
                        height: size.height * 0.1,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.history,
                          color: ColorConstant.primaryColor,
                          size: size.height * 0.03,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Lịch sử đặt lịch',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReportAndRatingScreen(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: size.height * 0.08,
                        height: size.height * 0.1,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.announcement,
                          color: ColorConstant.primaryColor,
                          size: size.height * 0.03,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Phản hồi & Đánh giá',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: size.height * 0.025,
              // ),
              // Container(
              //   width: size.width,
              //   height: size.height * 0.09,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: const BorderRadius.all(Radius.circular(18.5)),
              //     border: Border.all(
              //       color: ColorConstant.whiteEE,
              //     ),
              //   ),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.pushNamed(context, '/signUpScreen');
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           ImageConstant.ic_payment,
              //           height: size.height * 0.1,
              //           width: size.height * 0.08,
              //         ),
              //         SizedBox(
              //           width: size.width * 0.005,
              //         ),
              //         Text(
              //           'Phương thức thanh toán',
              //           style: GoogleFonts.roboto(
              //             color: Colors.black,
              //             fontWeight: FontWeight.w500,
              //             fontSize: size.height * 0.022,
              //           ),
              //         ),
              //         Expanded(
              //           child: Align(
              //             alignment: Alignment.centerRight,
              //             child: Padding(
              //               padding: EdgeInsets.only(
              //                 right: size.width * 0.04,
              //               ),
              //               child: Icon(
              //                 Icons.add,
              //                 size: size.height * 0.03,
              //                 color: ColorConstant.primaryColor,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/educationScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_education,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Học vấn',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/certificationScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_certificate,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Chứng nhận & Giấy phép',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // // Padding(
              // //   padding: EdgeInsets.only(
              // //     left: size.height * 0.03,
              // //     right: size.height * 0.03,
              // //   ),

              // Container(
              //   width: size.width,
              //   height: size.height * 0.09,
              //   decoration: BoxDecoration(
              //     color: Colors.white,

              //     borderRadius: const BorderRadius.all(Radius.circular(18.5)),

              //     border: Border.all(
              //       color: ColorConstant.whiteEE,
              //     ),
              //   ),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.pushNamed(context, '/achievementDetailScreen');
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           ImageConstant.ic_prize,
              //           height: size.height * 0.1,
              //           width: size.height * 0.08,
              //         ),
              //         SizedBox(
              //           width: size.width * 0.005,
              //         ),
              //         Text(
              //           'Giải thưởng & Thành tích',
              //           style: GoogleFonts.roboto(
              //             color: Colors.black,
              //             fontWeight: FontWeight.w500,
              //             fontSize: size.height * 0.022,
              //           ),
              //         ),
              //         Expanded(
              //           child: Align(
              //             alignment: Alignment.centerRight,
              //             child: Padding(
              //               padding: EdgeInsets.only(
              //                 right: size.width * 0.04,
              //               ),
              //               child: Icon(
              //                 Icons.add,
              //                 size: size.height * 0.03,
              //                 color: ColorConstant.primaryColor,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/workExperienceScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.icWorkExperience,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Kinh nghiệm làm việc',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetWorkingTimeScreen(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: size.height * 0.08,
                        height: size.height * 0.1,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.access_time,
                          color: ColorConstant.primaryColor,
                          size: size.height * 0.03,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Thời gian làm việc của bạn',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SitterPackageScreen(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_prize,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Gói dịch vụ của bạn',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(18.5)),
                  color: Colors.white,
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: size.height * 0.08,
                        height: size.height * 0.1,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.password,
                          color: ColorConstant.primaryColor,
                          size: size.height * 0.03,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Đổi mật khẩu',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(18.5)),
                  color: Colors.white,
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.logout();
                    globals.identifyInformation = null;
                    _elsBox.delete('checkLogin');
                    _elsBox.delete('email');
                    _elsBox.delete('password');
                    _authenBloc.logout(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_logout,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Đăng Xuất',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                height: 1,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: ColorConstant.whiteEE,
                ),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
