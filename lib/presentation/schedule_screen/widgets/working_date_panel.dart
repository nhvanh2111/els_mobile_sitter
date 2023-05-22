import 'package:elssit/presentation/schedule_screen/widgets/status_in_date_panel.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/booking_models/booking_full_detail_data_model.dart';

class WorkingDatePanel extends StatefulWidget {
  const WorkingDatePanel({Key? key, required this.booking}) : super(key: key);
  final BookingFullDetailDataModel booking;

  @override
  State<WorkingDatePanel> createState() =>
      // ignore: no_logic_in_create_state
      _WorkingDatePanelState(booking: booking);
}

class _WorkingDatePanelState extends State<WorkingDatePanel> {
  _WorkingDatePanelState({required this.booking});

  final BookingFullDetailDataModel booking;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: size.width,
      padding: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.05,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Tổng số ngày làm việc: ${booking.bookingDetailFormDtos.length} ngày",
                //   style: GoogleFonts.roboto(
                //     fontSize: size.height * 0.022,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                    //top: size.height * 0.01,
                    bottom: size.height * 0.01,
                    //left: size.width * 0.05,
                  ),
                  child: Text(
                    "Tổng số ngày làm việc: ",
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
                    bottom: size.height * 0.01,
                    left: size.width * 0.01,
                  ),
                  child: Text(
                    "${booking.bookingDetailFormDtos.length} ngày",
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
            ListView.separated(
                padding: EdgeInsets.only(
                  top: size.height * 0.01,
                  left: size.width * 0.05,
                ),
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ngày thứ ${index + 1}:",
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.022,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            Text(
                              booking.bookingDetailFormDtos[index].startDateTime
                                  .split("T")[0],
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            statusInDatePanel(
                                context,
                                booking.bookingDetailFormDtos[index]
                                    .bookingDetailStatus!),
                          ],
                        ),
                      ],
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: size.height * 0.005,
                    ),
                itemCount: booking.bookingDetailFormDtos.length),
            SizedBox(
              height: size.height * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
