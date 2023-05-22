import 'package:elssit/core/models/booking_models/booking_history_data_model.dart';
import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/core/utils/image_constant.dart';
import 'package:elssit/presentation/schedule_screen/widgets/schedule_booking_detail_screen.dart';
import 'package:elssit/presentation/schedule_screen/widgets/status_in_date_panel.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_formatter/money_formatter.dart';

import '../timeline_tracking_screen.dart';

Widget bookingItemWidgetV2(BuildContext context, BookingHistoryDataModel data) {
  var size = MediaQuery.of(context).size;
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 12.0,
      vertical: 4.0,
    ),
    padding: EdgeInsets.all(size.height * 0.01),
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.grey.withOpacity(0.4),
      ),
      borderRadius: BorderRadius.circular(size.height * 0.02),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstant.icScheduleItem,
              width: size.height * 0.08,
              height: size.height * 0.08,
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Khách hàng: ${data.customerDto.fullName}",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: size.height * 0.018,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    "Người thân: ${data.elderDto.fullName}",
                    maxLines: null,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: size.height * 0.018,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: size.height * 0.02,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Text(
                        "Từ: ${data.startDate.day}-${data.startDate.month}-${data.createDate.year} Đến: ${data.endDate.day}-${data.endDate.month}-${data.endDate.year}",
                        style: GoogleFonts.roboto(
                          color: Colors.black87,
                          fontSize: size.height * 0.016,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tổng tiền: ",
                        maxLines: null,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${MoneyFormatter(amount: data.totalPrice).output.withoutFractionDigits} VNĐ",
                        maxLines: null,
                        style: GoogleFonts.roboto(
                          color: ColorConstant.primaryColor,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          width: size.width,
          height: 1,
          color: Colors.grey.withOpacity(0.4),
          margin: EdgeInsets.symmetric(
            vertical: size.height * 0.015,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ScheduleBookingDetailScreen(bookingID: data.id),
                    ));
              },
              child: Row(
                children: [
                  Text(
                    "Chi tiết",
                    maxLines: null,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: size.height * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Container(
                    padding: EdgeInsets.all(size.height * 0.005),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstant.primaryColor.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.mode_rounded,
                      size: size.height * 0.02,
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            Container(
              height: size.height * 0.03,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4)),
              ),
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TimeLineTrackingScreen(
                        booking: data,
                      ),
                    ));
              },
              child: Row(
                children: [
                  Text(
                    "Thao tác",
                    maxLines: null,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: size.height * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Container(
                    padding: EdgeInsets.all(size.height * 0.005),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstant.yellowFF.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.settings_sharp,
                      size: size.height * 0.02,
                      color: ColorConstant.yellowFF,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
