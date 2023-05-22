import 'package:elssit/presentation/schedule_screen/widgets/service_items_in_jd_dialog.dart';
import 'package:elssit/presentation/schedule_screen/widgets/status_in_schedule_widget.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/models/booking_models/booking_full_detail_data_model.dart';
import '../../../core/utils/color_constant.dart';

class BookingSummaryPanel extends StatefulWidget {
  const BookingSummaryPanel({Key? key, required this.booking})
      : super(key: key);
  final BookingFullDetailDataModel booking;

  @override
  State<BookingSummaryPanel> createState() =>
      // ignore: no_logic_in_create_state
      _BookingSummaryPanelState(bookingDetail: booking);
}

class _BookingSummaryPanelState extends State<BookingSummaryPanel> {
  _BookingSummaryPanelState({required this.bookingDetail});

  final BookingFullDetailDataModel bookingDetail;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Trạng thái đặt lịch:",
                style: GoogleFonts.roboto(
                  fontSize: size.height * 0.022,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
              statusInScheduleWidget(context, bookingDetail.status),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            "Người đặt lịch:",
            style: GoogleFonts.roboto(
              fontSize: size.height * 0.022,
              fontWeight: FontWeight.w500,
            ),
          ),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: size.height * 0.1,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          size.height * 0.015),
                      image: DecorationImage(
                        image: NetworkImage(
                          bookingDetail.customerDto.image,
                        ),
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          bookingDetail.customerDto.fullName.toString(),
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          "${bookingDetail.customerDto.gender} - ${bookingDetail.customerDto.age} Tuổi",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          "Email: ${bookingDetail.customerDto.email}",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          "SĐT: ${bookingDetail.customerDto.phone}",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Text(
            "Nơi làm việc:",
            style: GoogleFonts.roboto(
              fontSize: size.height * 0.022,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.01,
              bottom: size.height * 0.02,
              left: size.width * 0.05,
            ),
            child: Text(
              //booking.startTime,
              bookingDetail.address,
              style: GoogleFonts.roboto(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ),
          Text(
            "Thời gian thực hiện:",
            style: GoogleFonts.roboto(
              fontSize: size.height * 0.022,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.01,
              bottom: size.height * 0.02,
              left: size.width * 0.05,
            ),
            child: Row(
              children: [
                Text(
                  //booking.startTime,
                  "Từ: ",
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                Text(
                  //booking.startTime,
                  DateFormat("dd - MM - yyyy ").format(bookingDetail.startDate),
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text(
                  //booking.startTime,
                  "Đến: ",
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                Text(
                  DateFormat("dd - MM - yyyy ").format(bookingDetail.endDate),
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              //top: size.height * 0.01,
              bottom: size.height * 0.02,
              //left: size.width * 0.05,
            ),
            child: Text(
              "Giờ làm việc mỗi ngày:",
              style: GoogleFonts.roboto(
                fontSize: size.height * 0.022,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              //top: size.height * 0.01,
              bottom: size.height * 0.02,
              left: size.width * 0.05,
            ),
            child: Text(
              "${bookingDetail.startTime} - ${bookingDetail.endTime}",
              style: GoogleFonts.roboto(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  //top: size.height * 0.01,
                  bottom: size.height * 0.02,
                  //left: size.width * 0.05,
                ),
                child: Text(
                  "Tổng tiền:",
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              Padding(
                padding: EdgeInsets.only(
                  //top: size.height * 0.01,
                  bottom: size.height * 0.02,
                  left: size.width * 0.01,
                ),
                child: Text(
                  "${NumberFormat.currency(symbol: "", locale: 'vi-vn').format(bookingDetail.totalPrice.ceil())} VNĐ",
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Gói dịch vụ",
            style: GoogleFonts.roboto(
              fontSize: size.height * 0.022,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          GestureDetector(
            onTap: () {
              showServiceItemsInJDDialog(context, bookingDetail);
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.01,
                bottom: size.height * 0.02,
                left: size.width * 0.05,
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    size: 17,
                    color: Color(0xFF5CB85C),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: Text(
                      bookingDetail.bookingDetailFormDtos[0].packageName,
                      style: GoogleFonts.roboto(
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


          SizedBox(
            height: size.height * 0.2,
          ),
        ],
      ),
    );
  }
}
