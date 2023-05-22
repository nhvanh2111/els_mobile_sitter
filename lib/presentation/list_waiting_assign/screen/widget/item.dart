import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/core/utils/image_constant.dart';
import 'package:elssit/presentation/list_waiting_assign/bloc/listwaiting_bloc.dart';
import 'package:elssit/presentation/list_waiting_assign/bloc/listwaitting_event.dart';
import 'package:elssit/presentation/list_waiting_assign/model/booking_waiting_acept.dart';
import 'package:elssit/presentation/schedule_screen/widgets/status_in_schedule_widget.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_formatter/money_formatter.dart';

Widget bWItemWidget(
    BuildContext context, BookingWAccept? data, ListWaittingBloc wBloc) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                // "Gói chăm sóc người già",
                "${data?.apackage.name}",
                textAlign: TextAlign.center,
              ),
            )
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
                    // "Khách hàng: ${data.elder.fullName}",
                    // "Nam: Nguyễn Văn A",
                      "${data?.elder.gender} : ${data?.elder.fullName}",
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
                    "Ngày bắt đầu: ${data?.startDate} (n ngày)",
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
                        // "${data?.slots}",
                        "08:00-12:00",
                        style: GoogleFonts.roboto(
                          color: Colors.black87,
                          fontSize: size.height * 0.016,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: size.height * 0.02,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Expanded(
                        child: Text(
                          // "Ốc bé man thiện Quận 9 Ốc bé man thiện Quận 9Ốc bé man thiện Quận 9",
                          "${data?.address}",
                          style: GoogleFonts.roboto(
                            color: Colors.black87,
                            fontSize: size.height * 0.016,
                            fontWeight: FontWeight.w300,
                          ),
                          overflow: TextOverflow.ellipsis,
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
                        // "1,550,000 VNĐ",
                        "${MoneyFormatter(amount: data?.totalPrice??0).output.withoutFractionDigits} VNĐ",
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
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: ColorConstant.primaryColor),
                    ),
                    backgroundColor: ColorConstant.primaryColor,
                  ),
                  onPressed: () {
                    wBloc.eventController.sink.add(AcceptListWaitingEvent(
                        idBooking: data!.bookingId, isAcept: true));
                  },
                  child: Text("Chấp nhận")),
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: ColorConstant.primaryColor),
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () {
                    wBloc.eventController.sink.add(AcceptListWaitingEvent(
                        idBooking: data!.bookingId, isAcept: false));
                  },
                  child: Text("Từ chối")),
            )
          ],
        )
      ],
    ),
  );
}
