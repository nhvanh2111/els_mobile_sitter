import 'dart:async';

import 'package:elssit/core/models/booking_models/booking_history_data_model.dart';
import 'package:elssit/core/models/rating_model/rating_data_model.dart';
import 'package:elssit/presentation/home_screen/widgets/balance_panel.dart';
import 'package:elssit/presentation/home_screen/widgets/work_panel.dart';
import 'package:elssit/presentation/list_waiting_assign/screen/list_waitting_accept.dart';
import 'package:elssit/presentation/test_deep_link_screen/test_deep_link_screen.dart';
import 'package:elssit/process/bloc/authen_bloc.dart';
import 'package:elssit/process/bloc/rating_bloc.dart';
import 'package:elssit/process/event/authen_event.dart';
import 'package:elssit/process/event/rating_event.dart';
import 'package:elssit/process/state/authen_state.dart';
import 'package:elssit/process/state/rating_state.dart';
import 'package:elssit/process/state/wallet_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/models/booking_models/booking_waiting_model.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/globals.dart' as globals;
import '../../process/bloc/booking_bloc.dart';
import '../../process/bloc/wallet_bloc.dart';
import '../../process/event/booking_event.dart';
import '../../process/event/wallet_event.dart';
import '../../process/state/booking_state.dart';
import '../request_screen/widgets/request_detail_screen.dart';
import '../request_screen/widgets/request_item.dart';
import '../timeline_tracking/screen/timeline_tracking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showAccountBalance = false;
  int tabIndex = 0;
  final _authenBloc = AuthenBloc();
  String fullName = (globals.identifyInformation != null)
      ? globals.identifyInformation!.fullName
      : "";
  final _walletBloc = WalletBloc();
  final ratingBloc = RatingBloc();

  int indexSchToday = 0;
  List<BookingHistoryDataModel> items = [];
  int lengthListDataTmp = 0;
  PageController _pageController = PageController();
  final _bookingBloc = BookingBloc();
  BookingWaitingAllModel? bookingWaitingList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authenBloc.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _authenBloc.eventController.sink.add(LoadInfo(context: context));
    });

    _walletBloc.eventController.sink.add(GetBalanceWalletEvent());
    ratingBloc.eventController.sink.add(GetAllRatingEvent());
    //Getdata toDay
    lengthListDataTmp = items.length;
    _bookingBloc.eventController.sink.add(GetBookingWatingEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _authenBloc.timer!.cancel();
    super.dispose();
  }

  nextSchedu() {
    setState(() {
      indexSchToday++;
      _pageController.jumpToPage(indexSchToday);
    });
  }

  backSchedu() {
    setState(() {
      indexSchToday--;
      _pageController.jumpToPage(indexSchToday);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: _authenBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is LoadDataState) {
              fullName = globals.identifyInformation!.fullName;
            }
          }
          return DefaultTabController(
            length: 2,
            child: Material(
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  bottomOpacity: 0,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: Text(
                    "Tổng quan",
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.022,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  actions: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          ImageConstant.icNotification,
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: size.width * 0.06,
                            left: size.width * 0.03,
                          ),
                          child: Container(
                            width: size.width * 0.03,
                            height: size.width * 0.03,
                            decoration: BoxDecoration(
                              color: ColorConstant.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Image(
                      image: AssetImage(ImageConstant.appLogo),
                      width: size.height * 0.05,
                      height: size.height * 0.05,
                    ),
                  ],
                ),
                body: Material(
                  child: Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: Text(
                              "Xin Chào",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.03,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  // ignore: unnecessary_null_comparison
                                  "$fullName 👋🏻",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.03,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: size.height * 0.05,
                                ),
                                padding: EdgeInsets.only(
                                  left: size.width * 0.05,
                                  right: size.width * 0.05,
                                  top: size.height * 0.02,
                                  bottom: size.height * 0.02,
                                ),
                                width: size.width,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(size.height * 0.03),
                                  color: ColorConstant.primaryColor
                                      .withOpacity(0.5),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Tổng số tiền",
                                          style: GoogleFonts.roboto(
                                            fontSize: size.height * 0.022,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Row(
                                      children: [
                                        StreamBuilder<Object>(
                                            stream: _walletBloc
                                                .stateController.stream,
                                            builder: (context, snapshot) {
                                              String balance = "0";
                                              if (snapshot.hasData) {
                                                if (snapshot.data
                                                    is GetBalanceWalletState) {
                                                  balance = (snapshot.data
                                                          as GetBalanceWalletState)
                                                      .balance;
                                                }
                                              }
                                              return Text(
                                                (_showAccountBalance)
                                                    ? "${NumberFormat.currency(symbol: "", locale: 'vi-vn').format(double.parse(balance).ceil())} đ"
                                                    : "******** đ",
                                                style: GoogleFonts.roboto(
                                                  fontSize: size.height * 0.026,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              );
                                            }),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              onToggleShowAccountBalance();
                                            });
                                          },
                                          child: Icon(
                                            _showAccountBalance
                                                ? Icons.remove_red_eye_outlined
                                                : Icons.remove_red_eye_outlined,
                                            color: _showAccountBalance
                                                ? ColorConstant.primaryColor
                                                : Colors.grey,
                                            size: size.height * 0.028,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              (globals.sitterStatus == "PENDING")
                                  ? Container(
                                      height: size.height * 0.13,
                                      margin: EdgeInsets.only(
                                        top: size.height * 0.05,
                                      ),
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.05,
                                        right: size.width * 0.05,
                                        top: size.height * 0.02,
                                        bottom: size.height * 0.02,
                                      ),
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              size.height * 0.03),
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 1,
                                            color: ColorConstant.primaryColor,
                                          )),
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.warning_rounded,
                                                size: size.height * 0.03,
                                                color:
                                                    ColorConstant.primaryColor,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.03,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Thông tin của bạn đã được gửi đến hệ thống. \nVui lòng đợi nhân viên của chúng tôi xác nhận',
                                                  maxLines: null,
                                                  style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize:
                                                        size.height * 0.018,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.05,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Phím tắt",
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.024,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.18,
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              // Navigator.push(context,
                                              //     '/listWaitingAcceptScreen');
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ListWaitingAcceptScreen(),
                                                  ));
                                            },
                                            child: Container(
                                              width: size.width * 0.15,
                                              height: size.width * 0.15,
                                              decoration: BoxDecoration(
                                                color: ColorConstant.yellow1
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              alignment: Alignment.center,
                                              child: ImageIcon(
                                                AssetImage(
                                                    ImageConstant.icService),
                                                color: ColorConstant.yellow1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Text(
                                            "Đơn mới",
                                            style: GoogleFonts.roboto(
                                              fontSize: size.height * 0.018,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.05,
                                    ),
                                    Container(
                                      width: size.width * 0.18,
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                  context, '/scheduleScreen');
                                            },
                                            child: Container(
                                              width: size.width * 0.15,
                                              height: size.width * 0.15,
                                              decoration: BoxDecoration(
                                                color: ColorConstant.blueSky1
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              alignment: Alignment.center,
                                              child: ImageIcon(
                                                AssetImage(
                                                    ImageConstant.icCalendar),
                                                color: ColorConstant.blueSky1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Text(
                                            "Lịch trình",
                                            style: GoogleFonts.roboto(
                                              fontSize: size.height * 0.018,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.05,
                                    ),
                                    Container(
                                      width: size.width * 0.18,
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/requestScreen');
                                            },
                                            child: Container(
                                              width: size.width * 0.15,
                                              height: size.width * 0.15,
                                              decoration: BoxDecoration(
                                                color: ColorConstant.purple1
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              alignment: Alignment.center,
                                              child: ImageIcon(
                                                AssetImage(
                                                    ImageConstant.icHistory2),
                                                color: ColorConstant.purple1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Text(
                                            "Tiến trình",
                                            style: GoogleFonts.roboto(
                                              fontSize: size.height * 0.018,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.05,
                                    ),
                                    Container(
                                      width: size.width * 0.18,
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/walletScreen');
                                            },
                                            child: Container(
                                              width: size.width * 0.15,
                                              height: size.width * 0.15,
                                              decoration: BoxDecoration(
                                                color: ColorConstant
                                                    .primaryColor
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              alignment: Alignment.center,
                                              child:
                                                  // ImageIcon(
                                                  //   AssetImage(ImageConstant
                                                  //       .icManageElder1),
                                                  Icon(
                                                Icons.wallet,
                                                color:
                                                    ColorConstant.primaryColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Text(
                                            "Ví của bạn",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                              fontSize: size.height * 0.018,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          // SizedBox(
                          //   height: size.height * 0.02,
                          // ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     SizedBox(
                          //       width: size.width,
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Container(
                          //             width: size.width * 0.18,
                          //             alignment: Alignment.center,
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.start,
                          //               children: [
                          //                 GestureDetector(
                          //                   onTap: () {
                          //                     Navigator.pushNamed(
                          //                         context, '/reportScreen');
                          //                   },
                          //                   child: Container(
                          //                     width: size.width * 0.15,
                          //                     height: size.width * 0.15,
                          //                     decoration: BoxDecoration(
                          //                       color: ColorConstant.blue1
                          //                           .withOpacity(0.1),
                          //                       shape: BoxShape.circle,
                          //                     ),
                          //                     alignment: Alignment.center,
                          //                     child: ImageIcon(
                          //                       AssetImage(
                          //                           ImageConstant.icReport),
                          //                       color: ColorConstant.blue1,
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: size.height * 0.01,
                          //                 ),
                          //                 Text(
                          //                   "Phản Hồi",
                          //                   style: GoogleFonts.roboto(
                          //                     fontSize: size.height * 0.018,
                          //                     color: Colors.black,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             width: size.width * 0.05,
                          //           ),
                          //           GestureDetector(
                          //             onTap: () {
                          //               // Navigator.push(context, MaterialPageRoute(builder: (context) => TestDeepLinkScreen(),));
                          //             },
                          //             child: Container(
                          //               width: size.width * 0.18,
                          //               alignment: Alignment.center,
                          //               child: Column(
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.center,
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.start,
                          //                 children: [
                          //                   Container(
                          //                     width: size.width * 0.15,
                          //                     height: size.width * 0.15,
                          //                     decoration: BoxDecoration(
                          //                       color: ColorConstant
                          //                           .primaryColor
                          //                           .withOpacity(0.1),
                          //                       shape: BoxShape.circle,
                          //                     ),
                          //                     alignment: Alignment.center,
                          //                     child: ImageIcon(
                          //                       AssetImage(
                          //                           ImageConstant.icMore),
                          //                       color:
                          //                           ColorConstant.primaryColor,
                          //                     ),
                          //                   ),
                          //                   SizedBox(
                          //                     height: size.height * 0.01,
                          //                   ),
                          //                   Text(
                          //                     "Thêm",
                          //                     style: GoogleFonts.roboto(
                          //                       fontSize: size.height * 0.018,
                          //                       color: Colors.black,
                          //                       fontWeight: FontWeight.bold,
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             width: size.width * 0.05,
                          //           ),
                          //           Container(
                          //             width: size.width * 0.18,
                          //             alignment: Alignment.center,
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.start,
                          //               children: [
                          //                 Container(
                          //                   width: size.width * 0.15,
                          //                   height: size.width * 0.15,
                          //                   decoration: BoxDecoration(
                          //                     color: ColorConstant.primaryColor
                          //                         .withOpacity(0.1),
                          //                     shape: BoxShape.circle,
                          //                   ),
                          //                   alignment: Alignment.center,
                          //                   child: ImageIcon(
                          //                     AssetImage(ImageConstant.icMore),
                          //                     color: ColorConstant.primaryColor,
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: size.height * 0.01,
                          //                 ),
                          //                 Text(
                          //                   "Thêm",
                          //                   style: GoogleFonts.roboto(
                          //                     fontSize: size.height * 0.018,
                          //                     color: Colors.black,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             width: size.width * 0.05,
                          //           ),
                          //           Container(
                          //             width: size.width * 0.18,
                          //             alignment: Alignment.center,
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.start,
                          //               children: [
                          //                 Container(
                          //                   width: size.width * 0.15,
                          //                   height: size.width * 0.15,
                          //                   decoration: BoxDecoration(
                          //                     color: ColorConstant.primaryColor
                          //                         .withOpacity(0.1),
                          //                     shape: BoxShape.circle,
                          //                   ),
                          //                   alignment: Alignment.center,
                          //                   child: ImageIcon(
                          //                     AssetImage(ImageConstant.icMore),
                          //                     color: ColorConstant.primaryColor,
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: size.height * 0.01,
                          //                 ),
                          //                 Text(
                          //                   "Thêm",
                          //                   style: GoogleFonts.roboto(
                          //                     fontSize: size.height * 0.018,
                          //                     color: Colors.black,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.02,
                              left: size.width * 0.05,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Lịch trình hôm nay",
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.024,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          StreamBuilder<Object>(
                              stream: _bookingBloc.stateController.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data is GetWaitingBookingState) {
                                    items.clear();
                                    for (var element in (snapshot.data
                                            as GetWaitingBookingState)
                                        .bookingWaitingList
                                        .data) {
                                      items.add(element);
                                    }
                                  }
                                }
                                if (items.isNotEmpty) {
                                  return _scheduleToday(size);
                                } else {
                                  return const SizedBox();
                                }
                              }),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.05,
                              top: size.height * 0.01,
                            ),
                            child: Text(
                              "Đánh giá của bạn",
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                          ),
                          StreamBuilder<Object>(
                              stream: ratingBloc.stateController.stream,
                              builder: (context, snapshot) {
                                RatingDataModel ratingData = RatingDataModel(
                                    countOneRate: 0,
                                    countTwoRate: 0,
                                    countThreeRate: 0,
                                    countFourRate: 0,
                                    countFiveRate: 0,
                                    hasTag: "",
                                    average: "0");
                                if (snapshot.hasData) {
                                  if (snapshot.data is GetAllRatingState) {
                                    ratingData =
                                        (snapshot.data as GetAllRatingState)
                                            .ratingData;
                                  }
                                }
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.07,
                                    top: size.height * 0.03,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Điểm trung bình: ",
                                        style: GoogleFonts.roboto(
                                          fontSize: size.height * 0.022,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ),
                                      Text(
                                        "${(ratingData.average != "NaN") ? ratingData.average : "0"} - ${ratingData.countFiveRate + ratingData.countFourRate + ratingData.countThreeRate + ratingData.countTwoRate + ratingData.countOneRate} lượt",
                                        style: GoogleFonts.roboto(
                                          fontSize: size.height * 0.022,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                          SizedBox(
                            height: size.height * 0.2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void onToggleShowAccountBalance() {
    setState(() {
      _showAccountBalance = !_showAccountBalance;
    });
  }

  Container _scheduleToday(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.1, vertical: size.height * 0.02),
      height: size.height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          PageView.custom(
            controller: _pageController,
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // return bookingItemWidget(context," value[index].title");

                return ListTile(
                  contentPadding: EdgeInsets.all(size.width * 0.05),
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TimeLineTrackingScreen(booking: items[index]),
                          ));
                    },
                    child: Image.asset(
                      ImageConstant.icScheduleItem,
                      width: size.height * 0.05,
                      height: size.height * 0.05,
                    ),
                  ),
                  title: Text(
                    "Khách hàng: ${items[index].customerDto.fullName}",
                    style: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        "Thân nhân: ${items[index].elderDto.fullName}",
                        style: GoogleFonts.roboto(
                          color: Colors.black87,
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: size.height * 0.03,
                            color: Colors.black.withOpacity(0.8),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Expanded(
                            child: Text(
                              "Bắt đầu: ${items[index].startTime}",
                              style: GoogleFonts.roboto(
                                color: Colors.black87,
                                fontSize: size.height * 0.018,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        "${items[index].address}",
                        style: GoogleFonts.roboto(
                          color: Colors.black87,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: items.length,
              // findChildIndexCallback: (Key key) {
              //   final ValueKey<String> valueKey =
              //       key as ValueKey<String>;
              //   final String data = valueKey.value;
              //   return items.indexOf(data);
              // }
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              indexSchToday != 0
                  ? InkWell(
                      onTap: backSchedu,
                      child: const SizedBox(
                        height: double.infinity,
                        width: 20,
                        child: Icon(Icons.arrow_back_ios_outlined),
                      ),
                    )
                  : const SizedBox.shrink(),
              indexSchToday != lengthListDataTmp - 1
                  ? InkWell(
                      onTap: nextSchedu,
                      child: const SizedBox(
                        height: double.infinity,
                        width: 20,
                        child: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }
}
