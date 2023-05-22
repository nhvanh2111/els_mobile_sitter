import 'package:elssit/core/models/booking_models/booking_history_data_model.dart';
import 'package:elssit/core/utils/image_constant.dart';
import 'package:elssit/presentation/history_screen/widgets/status_in_history.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/color_constant.dart';

Widget historyItem(
    BuildContext context, BookingHistoryDataModel bookingHistory) {
  var size = MediaQuery.of(context).size;
  return Container(
    color: Colors.white,
    child: Container(
      width: size.width,
      color: Colors.white,
      margin: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.05,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            ImageConstant.icAva,
            width: size.height * 0.08,
            height: size.height * 0.08,
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.6,
                child: Text(
                  "${NumberFormat.currency(symbol: "", locale: 'vi-vn').format(bookingHistory.totalPrice.ceil())} VNĐ",
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                width: size.width * 0.6,
                child: Text(
                  bookingHistory.address,
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              // Text(
              //   bookingHistory.status,
              //   style: GoogleFonts.roboto(
              //     fontSize: size.height * 0.022,
              //     fontWeight: FontWeight.w400,
              //     color: Colors.black.withOpacity(0.7),
              //   ),
              // ),
              statusInHistoryPanel(context, bookingHistory.status),
              SizedBox(
                height: size.height * 0.015,
              ),
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              height: size.height * 0.12,
              child: Icon(
                Icons.arrow_forward,
                size: size.height * 0.03,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
