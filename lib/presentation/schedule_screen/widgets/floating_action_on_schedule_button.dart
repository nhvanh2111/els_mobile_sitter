import 'package:elssit/core/models/booking_models/booking_detail_form_dto.dart';
import 'package:elssit/core/utils/my_utils.dart';
import 'package:elssit/presentation/checkin_checkout_screen/checkin_checkout_screen.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/booking_models/booking_full_detail_data_model.dart';
import '../../../core/utils/color_constant.dart';
import '../../report_screen/add_new_report_screen.dart';

Widget floatingActionOnScheduleButton(
    BuildContext context, BookingFullDetailDataModel booking) {
  var size = MediaQuery.of(context).size;
  BookingDetailFormDto? bookingDetail;
  String curDate =
      MyUtils().convertDateToStringInput(DateTime.now()).split("T")[0];
  for (var element in booking.bookingDetailFormDtos) {
    if (element.startDateTime.split("T")[0] == curDate ||
        element.endDateTime.split("T")[0] == curDate) {
      if (element.bookingDetailStatus != "DONE") {
        bookingDetail = element;
        break;
      }
    }
  }
  if (booking.status == "ASSIGNED") {
    return const SizedBox();
  } else if (booking.status == "COMPLETED") {
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.height * 0.12,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: size.width * 0.4,
          height: size.height * 0.06,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.height * 0.03),
              ),
              textStyle: TextStyle(
                fontSize: size.width * 0.045,
              ),
            ),
            child: const Text("Phản Hồi"),
          ),
        ),
      ),
    );
  } else if (booking.status == "IN_PROGRESS") {
    print("faill -${booking.latitude},${booking.longitude}");
    if (bookingDetail != null &&
        bookingDetail.bookingDetailStatus == "WORKING") {
      return Container(
        color: Colors.white,
        width: size.width,
        height: size.height * 0.12,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNewReportScreen(
                              bookingDetailId: (bookingDetail != null)
                                  ? bookingDetail.id
                                  : "",
                              customerID: booking.customerDto.id),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor:
                        ColorConstant.primaryColor.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                    ),
                  ),
                  child: Text(
                    "Phản Hồi",
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.022,
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (bookingDetail != null &&
        bookingDetail.bookingDetailStatus == "WAITING") {
      return Container(
        color: Colors.white,
        width: size.width,
        height: size.height * 0.12,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckinCheckoutScreen(
                            bookingID: booking.id,
                            location: booking.address,
                            dateStatus:
                                bookingDetail!.bookingDetailStatus.toString(),
                            checkInDateTime: bookingDetail.startDateTime,
                            lat: booking.latitude,
                            lng: booking.longitude,
                          ),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                    ),
                    textStyle: TextStyle(
                      fontSize: size.width * 0.045,
                    ),
                  ),
                  child: const Text("Bắt đầu"),
                ),
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor:
                        ColorConstant.primaryColor.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                    ),
                  ),
                  child: Text(
                    "Phản Hồi",
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.022,
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        width: size.width,
        height: size.height * 0.12,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNewReportScreen(
                              bookingDetailId: (bookingDetail != null)
                                  ? bookingDetail.id
                                  : "",
                              customerID: booking.customerDto.id),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor:
                        ColorConstant.primaryColor.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                    ),
                  ),
                  child: Text(
                    "Phản Hồi",
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.022,
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  } else {
    return const SizedBox();
  }
}
