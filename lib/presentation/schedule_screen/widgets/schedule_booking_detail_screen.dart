import 'package:elssit/core/utils/image_constant.dart';
import 'package:elssit/presentation/schedule_screen/widgets/floating_action_on_schedule_button.dart';
import 'package:elssit/presentation/schedule_screen/widgets/working_date_panel.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/booking_models/booking_detail_form_dto.dart';
import '../../../core/models/booking_models/booking_full_detail_model.dart';
import '../../../core/utils/color_constant.dart';
import '../../../core/utils/my_utils.dart';
import '../../../process/bloc/booking_bloc.dart';
import '../../../process/event/booking_event.dart';
import '../../../process/state/booking_state.dart';
import '../../chat_screen/chat_screen.dart';
import '../../checkin_checkout_screen/checkin_checkout_screen.dart';
import '../../loading_screen/loading_screen.dart';
import 'booking_summary_panel.dart';

class ScheduleBookingDetailScreen extends StatefulWidget {
  const ScheduleBookingDetailScreen({Key? key, required this.bookingID})
      : super(key: key);
  final String bookingID;

  @override
  // ignore: no_logic_in_create_state
  State<ScheduleBookingDetailScreen> createState() =>
      // ignore: no_logic_in_create_state
      _ScheduleBookingDetailScreenState(bookingID: bookingID);
}

class _ScheduleBookingDetailScreenState
    extends State<ScheduleBookingDetailScreen> {
  _ScheduleBookingDetailScreenState({required this.bookingID});

  final String bookingID;
  final _bookingBloc = BookingBloc();
  BookingFullDetailModel? booking;
  BookingDetailFormDto? bookingDetail;
  String curDate =
      MyUtils().convertDateToStringInput(DateTime.now()).split("T")[0];

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
              textAlign: TextAlign.center,
              "Tóm Tắt Đặt Lịch",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),

          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Chi Tiết Lịch Trình",
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
            for (var element in booking!.data.bookingDetailFormDtos) {
              if (element.startDateTime.split("T")[0] == curDate) {
                bookingDetail = element;
              }
            }
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
                        "Mô Tả Lịch Trình",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: size.height * 0.024,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    (booking!.data.status != "PAID" &&
                        booking!.data.status != "CANCEL")
                        ? PopupMenuButton(
                        icon: ImageIcon(
                          AssetImage(ImageConstant.icMoreFunc),
                          size: size.height * 0.03,
                          color: ColorConstant.primaryColor,
                        ),
                        itemBuilder: (context) {
                          return [

                            PopupMenuItem<int>(
                              value: 0,
                              child: Row(
                                children: [
                                  ImageIcon(
                                    AssetImage(ImageConstant.icChat),
                                    size: size.height * 0.025,
                                    color: ColorConstant.primaryColor.withOpacity(0.6),
                                  ),
                                  Text(
                                    "  Trò chuyện",
                                    style: GoogleFonts.roboto(
                                      fontSize: size.height * 0.022,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ];
                        },
                        onSelected: (value) {
                          if (value == 0) {
                            print("faill -${booking!.data.latitude},${booking!.data.longitude}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    otherID: booking!.data.customerDto.id,
                                    otherName:
                                    booking!.data.customerDto.fullName,
                                    otherEmail:
                                    booking!.data.customerDto.email,
                                    otherAvaUrl:
                                    booking!.data.customerDto.image),
                              ),
                            );
                          }
                        })
                        : const SizedBox(),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton:
                    floatingActionOnScheduleButton(context, booking!.data),
                body: Stack(
                  children: [
                    Container(
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
                            ),
                            padding: EdgeInsets.only(
                              top: size.height * 0.015,
                              left: size.width * 0.03,
                              right: size.width * 0.03,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Người được chăm sóc",
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.height * 0.022,
                                      color: ColorConstant.primaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ImageIcon(
                                      AssetImage(ImageConstant.icPerson),
                                      size: size.height * 0.03,
                                      color: ColorConstant.primaryColor
                                          .withOpacity(0.8),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Text(
                                      //booking.startTime,
                                      "${booking!.data.elderDto.fullName} - ${booking!.data.elderDto.gender} - ${booking!.data.elderDto.age} Tuổi",
                                      style: GoogleFonts.roboto(
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ImageIcon(
                                      AssetImage(ImageConstant.icHealthStatus),
                                      size: size.height * 0.03,
                                      color: ColorConstant.primaryColor
                                          .withOpacity(0.8),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Expanded(
                                      child: Text(
                                        //booking.startTime,
                                        booking!.data.elderDto.healthStatus,
                                        style: GoogleFonts.roboto(
                                          fontSize: size.height * 0.02,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          (booking!.data.status == "ASSIGNED")
                              ? Container(
                                  width: size.width,
                                  margin: EdgeInsets.only(
                                    top: size.height * 0.02,
                                    left: size.width * 0.05,
                                    right: size.width * 0.05,
                                    bottom: size.height * 0.02,
                                  ),
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.015,
                                    left: size.width * 0.05,
                                    right: size.width * 0.05,
                                    bottom: size.height * 0.015,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        size.height * 0.02),
                                    border: Border.all(
                                      width: 1,
                                      color: ColorConstant.primaryColor.withOpacity(0.5),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            ImageConstant.icNotice,
                                            width: size.height * 0.03,
                                            height: size.height * 0.03,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Lịch trình chưa được bắt đầu",
                                              style: GoogleFonts.roboto(
                                                fontSize: size.height * 0.02,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: size.width * 0.55,
                                          height: size.height * 0.04,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CheckinCheckoutScreen(
                                                      bookingID:
                                                          booking!.data.id,
                                                      location:
                                                          booking!.data.address,
                                                      dateStatus: (bookingDetail !=
                                                              null)
                                                          ? bookingDetail!
                                                              .bookingDetailStatus
                                                              .toString()
                                                          : "WAITING",
                                                      checkInDateTime:
                                                          (bookingDetail !=
                                                                  null)
                                                              ? bookingDetail!
                                                                  .startDateTime
                                                              : booking!
                                                                  .data
                                                                  .bookingDetailFormDtos[
                                                                      0]
                                                                  .startDateTime,
                                                      lat: booking!
                                                          .data.latitude,
                                                      lng: booking!
                                                          .data.longitude,
                                                    ),
                                                  ));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorConstant.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.height * 0.03),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Bắt đầu ngay",
                                                  style: GoogleFonts.roboto(
                                                    fontSize:
                                                        size.height * 0.022,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.05,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  size: size.height * 0.025,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
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
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          BookingSummaryPanel(
                                              booking: booking!.data),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          WorkingDatePanel(
                                              booking: booking!.data),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _bookingBloc.statusCheckIn == "CHECK_IN"
                        ? Positioned(
                            top: 0,
                            child: Container(
                              height: size.height * 0.02,
                              width: size.width,
                              color: Colors.red.shade600,
                              child: Text(
                                "Hôm nay bạn có việc nhớ check in nhé",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: size.height * 0.016,
                                ),
                              ),
                            ),
                          )
                        : _bookingBloc.statusCheckIn == "CHECK_OUT"
                            ? Positioned(
                                top: 0,
                                child: Container(
                                  height: size.height * 0.02,
                                  width: size.width,
                                  color: Colors.blue.shade600,
                                  child: Text(
                                    "Khi hoàn thành xong công việc nhớ check out nhé",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: size.height * 0.016,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox()
                  ],
                ),
              ),
            );
          } else {
            return const LoadingScreen();
          }
        });
  }
}
