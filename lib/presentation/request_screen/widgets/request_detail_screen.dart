import 'package:elssit/core/models/booking_models/booking_full_detail_model.dart';
import 'package:elssit/core/utils/image_constant.dart';
import 'package:elssit/presentation/cancel_booking_screen/cancel_booking_screen.dart';
import 'package:elssit/presentation/loading_screen/loading_screen.dart';
import 'package:elssit/process/bloc/booking_bloc.dart';
import 'package:elssit/process/event/booking_event.dart';
import 'package:elssit/process/state/booking_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/color_constant.dart';
import 'job_description_panel.dart';

class RequestDetailScreen extends StatefulWidget {
  const RequestDetailScreen({Key? key, required this.bookingID})
      : super(key: key);
  final String bookingID;
  @override
  State<RequestDetailScreen> createState() =>
      _RequestDetailScreenState(bookingID: bookingID);
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  _RequestDetailScreenState({required this.bookingID});
  final String bookingID;

  final _bookingBloc = BookingBloc();
  BookingFullDetailModel? booking;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bookingBloc.eventController.sink
        .add(GetFullDetailBookingEvent(bookingID: bookingID));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TabBar createTabBar() {
      return TabBar(
        indicatorColor: ColorConstant.primaryColor,
        labelPadding: const EdgeInsets.all(10),
        tabs: [
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              "Mô tả công việc",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
          // SizedBox(
          //   width: size.width * 0.5,
          //   child: const Text(
          //     textAlign: TextAlign.center,
          //     "Kỹ năng yêu cầu",
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 17,
          //     ),
          //   ),
          // ),
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Tóm tắt công việc",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ],
        isScrollable: true,
      );
    }

    return StreamBuilder<Object>(
        stream: _bookingBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is GetFullDetailBookingState) {
              booking = (snapshot.data as GetFullDetailBookingState).booking;
              _bookingBloc.eventController.add(OtherBookingEvent());
            }
          }
          if (booking != null) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: size.height * 0.08,
                  bottomOpacity: 0.0,
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: size.height * 0.03,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  title: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: size.height * 0.01,
                        bottom: size.height * 0.01,
                      ),
                      child: Text(
                        "Xác nhận yêu cầu",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: size.height * 0.024,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_outlined,
                        size: size.height * 0.03,
                        color: Colors.black,
                      ),
                    ),
                  ],
                  // bottom: createTabBar(),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Container(
                  color: Colors.white,
                  width: size.width,
                  height: size.height * 0.12,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.9,
                          height: size.height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CancelBookingScreen(
                                        bookingID: booking!.data.id),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  ColorConstant.primaryColor.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.03),
                              ),
                              textStyle: TextStyle(
                                fontSize: size.width * 0.045,
                              ),
                            ),
                            child: Text(
                              "Từ chối",
                              style: GoogleFonts.roboto(
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: size.width * 0.03,
                        // ),
                        // SizedBox(
                        //   width: size.width * 0.4,
                        //   height: size.height * 0.06,
                        //   child: ElevatedButton(
                        //     onPressed: () {},
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: ColorConstant.primaryColor,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius:
                        //             BorderRadius.circular(size.height * 0.03),
                        //       ),
                        //       textStyle: TextStyle(
                        //         fontSize: size.width * 0.045,
                        //       ),
                        //     ),
                        //     child: const Text("Chấp nhận"),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                body: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(
                          top: size.height * 0.02,
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                          bottom: size.height * 0.02,
                        ),
                        padding: EdgeInsets.only(
                          top: size.height * 0.015,
                          left: size.width * 0.042,
                          right: size.width * 0.042,
                          bottom: size.height * 0.015,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(size.height * 0.02),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              "Người cần chăm sóc",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.022,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Text(
                              booking!.data.elderDto.fullName,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.035,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Text(
                              "${booking!.data.elderDto.age} Tuổi",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.022,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                            Container(
                              width: size.width,
                              height: 1,
                              margin: EdgeInsets.only(
                                top: size.height * 0.025,
                                bottom: size.height * 0.025,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                            Text(
                              booking!.data.address,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.022,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Text(
                              //"${booking!.data.totalPrice} / ngày",
                              "${NumberFormat.currency(symbol: "", locale: 'vi-vn').format(booking!.data.totalPrice.ceil())} VNĐ / ngày",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.022,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.04,
                                    right: size.width * 0.04,
                                    top: size.height * 0.005,
                                    bottom: size.height * 0.005,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        size.height * 0.005),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                  child: Text(
                                    "${booking!.data.bookingDetailFormDtos[0].estimateTime} giờ",
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400,
                                      fontSize: size.height * 0.014,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.018,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.025,
                                    right: size.width * 0.025,
                                    top: size.height * 0.005,
                                    bottom: size.height * 0.005,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        size.height * 0.005),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                  child: Text(
                                    "${DateFormat("dd/MM/yyyy").format(booking!.data.startDate)} - ${DateFormat("dd/MM/yyyy ").format(booking!.data.endDate)} |  ${booking!.data.startTime.substring(0, 5)} - ${booking!.data.endTime.substring(0, 5)}",
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400,
                                      fontSize: size.height * 0.014,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Text(
                              "( Bạn có 24 giờ để từ chối. Sau 24 giờ trạng thái của yêu cầu này sẽ tự động chấp nhận )",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                fontSize: size.height * 0.015,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                            // SizedBox(
                            //   height: size.height * 0.015,
                            // ),
                            // Text(
                            //   "Bạn có 1 giờ để chấp nhận.",
                            //   style: GoogleFonts.roboto(
                            //     fontWeight: FontWeight.w500,
                            //     fontSize: size.height * 0.02,
                            //     color: Colors.black.withOpacity(0.8),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      createTabBar(),
                      Expanded(
                        child: Container(
                          color: Colors.yellow,
                          child: TabBarView(children: [
                            Material(
                              child: Container(
                                color: Colors.white,
                                width: size.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.03,
                                      ),
                                      JobDescriptionPanel(
                                          bookingDetail: booking!.data
                                              .bookingDetailFormDtos.first),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              child: Container(
                                color: Colors.white,
                                width: size.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.03,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Material(
                            //   child: Container(
                            //     color: Colors.white,
                            //     width: size.width,
                            //     child: SingleChildScrollView(
                            //       child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.center,
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         children: [
                            //           SizedBox(
                            //             height: size.height * 0.03,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const LoadingScreen();
          }
        });
  }
}
