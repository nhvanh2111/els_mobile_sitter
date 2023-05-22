import 'package:elssit/core/models/booking_models/booking_full_detail_model.dart';
import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/core/utils/my_utils.dart';
import 'package:elssit/presentation/widget/dialog/confirm_check_dialog.dart';
import 'package:elssit/process/bloc/checkin_checkout.dart';
import 'package:elssit/process/event/checkin_checkout_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elssit/core/utils/color_constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:permission_handler/permission_handler.dart' as perMiss;

class CheckinCheckoutScreen extends StatefulWidget {
  CheckinCheckoutScreen(
      {Key? key,
      required this.bookingID,
      required this.location,
      required this.dateStatus,
      required this.checkInDateTime,
      required this.lat,
      required this.lng
      })
      : super(key: key);
  String bookingID;
  String location;
  String dateStatus;
  String checkInDateTime;
  double lat;
  double lng;

  @override
  State<CheckinCheckoutScreen> createState() =>
      // ignore: no_logic_in_create_state
      _CheckinCheckoutScreenState(
          bookingID: bookingID,
          location: location,
          dateStatus: dateStatus,
          checkInDateTime: checkInDateTime,
          lat: lat,
          lng: lng
          );
}

class _CheckinCheckoutScreenState extends State<CheckinCheckoutScreen> {
  _CheckinCheckoutScreenState(
      {required this.bookingID,
      required this.location,
      required this.dateStatus,
      required this.checkInDateTime,
      required this.lat,
      required this.lng
      });

  String bookingID;
  String location;
  String dateStatus;
  String checkInDateTime;
  String checkIn = "--/--";
  DateTime? startDateTime;
  DateTime? endDateTime;
  String checkOut = "--/--";
  double lat;
  double lng;
  final _checkinCheckoutBloc = CheckinCheckOutBloc();
  String fullName = "";
  BookingFullDetailModel? booking;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (dateStatus == "WORKING") {
      checkIn = (checkInDateTime.split("T")[1]);
    }
  }

  handlePermission(BuildContext context) async {
    // await testRequestLocationPermission();
    perMiss.PermissionStatus permisstionCheck =
        await perMiss.Permission.location.status;
    if (permisstionCheck == perMiss.PermissionStatus.granted) {
    
    } else {
      QuickAlert.show(
        context: context,
        title: "Quyền truy cập vị trí chưa bật",
        text: "Để thực hiện việc check in cần phải bật quyền truy cập vị trí",
        type: QuickAlertType.warning,
        confirmBtnText: "OK",
        onConfirmBtnTap: () async {
          Navigator.pop(context);
          await testRequestLocationPermission(context);
        },
        cancelBtnText: "Huỷ",
        showCancelBtn: true,
        onCancelBtnTap: () {
          Navigator.pop(context);
        },
      );
    }
  }

  Future<void> testRequestLocationPermission(BuildContext context) async {
    perMiss.PermissionStatus locationStatus =
        await perMiss.Permission.location.request();
    if (locationStatus != perMiss.PermissionStatus.granted) {
//Show thông báo

      if (locationStatus == perMiss.PermissionStatus.denied) {
        await QuickAlert.show(
            title: "Quyền truy cập vị trí",
            text:
                "Chúng tôi cần xác định bạn đã đến đúng điểm làm việc hay chưa",
            context: context,
            type: QuickAlertType.warning,
            confirmBtnText: "OK",
            onConfirmBtnTap: () async {
              Navigator.pop(context);
              await perMiss.Permission.location.request();
            },
            onCancelBtnTap: () {
              Navigator.pop(context);
            },
            showCancelBtn: true);
      } else if (locationStatus == perMiss.PermissionStatus.permanentlyDenied) {
        //Show thông báo Bị từ chối vĩnh viễn
        await QuickAlert.show(
            title: "Quyền vị trí đã bị tắt vĩnh viễn",
            text: "1. Mở cài đặt ứng dụng"
                "\n"
                "2. Chọn ứng dụng Elsit"
                "\n"
                "3. Chọn quản lý quyền"
                "\n"
                "4. Chọn quyền vị trí và bật",
            context: context,
            type: QuickAlertType.warning,
            onConfirmBtnTap: () async {
              Navigator.pop(context);
              await perMiss.openAppSettings();
            },
            onCancelBtnTap: () {
              Navigator.pop(context);
            },
            showCancelBtn: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            size: size.height * 0.03,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await handlePermission(context);
          perMiss.PermissionStatus permisstionCheck =
              await perMiss.Permission.location.status;
          if (permisstionCheck == perMiss.PermissionStatus.granted) {
         Position locationCurrent=  await Geolocator.getCurrentPosition();
         print(locationCurrent);
              // LocationData locationCurrent = await Location.instance.getLocation();
  // // Location.instance.
            if (dateStatus == "WAITING") {
              showConfirmCheckDialog(context, "Xác nhận bắt đầu",
                  _checkinCheckoutBloc, bookingID, startDateTime!, "${locationCurrent.latitude},${locationCurrent.longitude}",locationCurrent,lat,lng);
            } else if (dateStatus == "WORKING") {
              showConfirmCheckDialog(context, "Xác nhận kết thức",
                  _checkinCheckoutBloc, bookingID, endDateTime!, location,locationCurrent,lat,lng);
            }
          }
        },
        elevation: 0.0,
        backgroundColor: ColorConstant.primaryColor,
        child: Icon(
          Icons.check,
          size: size.height * 0.05,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 0),
              child: Text(
                'Xin chào,',
                style: GoogleFonts.roboto(
                  color: ColorConstant.gray43,
                  fontWeight: FontWeight.w400,
                  fontSize: size.width / 20,
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.centerLeft,
            //   margin: EdgeInsets.only(top: size.height * 0.03),
            //   child: Text(
            //     "${booking?.data.sitterDto.fullName}",
            //     style: GoogleFonts.roboto(
            //       color: ColorConstant.gray43,
            //       fontWeight: FontWeight.w500,
            //       fontSize: size.width / 18,
            //     ),
            //   ),
            // ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32, bottom: 25),
              child: Text(
                'Trạng thái công việc của bạn',
                style: GoogleFonts.roboto(
                  color: ColorConstant.gray43,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width / 20,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 32),
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Bắt đầu làm việc',
                            style: GoogleFonts.roboto(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: size.width / 20,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            checkIn,
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: size.width / 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Kết thúc làm việc',
                            style: GoogleFonts.roboto(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: size.width / 20,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            checkOut,
                            style: GoogleFonts.roboto(
                              color: ColorConstant.gray43,
                              fontWeight: FontWeight.w700,
                              fontSize: size.width / 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                    text: DateTime.now().day.toString(),
                    style: GoogleFonts.roboto(
                      color: ColorConstant.primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: size.width / 18,
                    ),
                    children: [
                      TextSpan(
                        text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: size.width / 20,
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: GoogleFonts.roboto(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                        fontSize: size.width / 19,
                      ),
                    ),
                  );
                }),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Builder(builder: (context) {
                final GlobalKey<SlideActionState> key = GlobalKey();

                return SlideAction(
                  text: _getSlideText(),
                  textStyle: GoogleFonts.roboto(
                      color: Colors.black54, fontSize: size.width / 20),
                  outerColor: Colors.white,
                  innerColor: ColorConstant.primaryColor,
                  key: key,
                  onSubmit: () async {
                    //print(DateFormat("hh:mm").format(DateTime.now()));
                    setState(() {
                      if (dateStatus == "WORKING") {
                        checkOut = DateFormat('hh:mm').format(DateTime.now());
                        endDateTime = DateTime.now();
                      } else if (dateStatus == "WAITING") {
                        checkIn = DateFormat('hh:mm').format(DateTime.now());
                        startDateTime = DateTime.now();
                      }
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  String _getSlideText() {
    if (checkIn == "--/--") {
      return "Vuốt để bắt đầu";
    } else {
      if (dateStatus == "WORKING") {
        return "Vuốt để kết thúc";
      } else {
        return "Xác nhận bắt đầu";
      }
    }
  }
}
