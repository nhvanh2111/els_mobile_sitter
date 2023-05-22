
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/booking_models/booking_full_detail_data_model.dart';

Future<void> showServiceItemsInJDDialog(BuildContext context,
    BookingFullDetailDataModel bookingDetail) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size.height*0.015)),
        content: Container(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Các công việc có trong gói dịch vụ:",
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                ListView.separated(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                    ),
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Row(
                      children: [
                        const CircleAvatar(
                          radius: 12,
                          backgroundColor: Color(0xFFF1F9F1),
                          child: Icon(
                            Icons.done,
                            size: 17,
                            color: Color(0xFF5CB85C),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: size.width * 0.5,
                            child: Text(

                              bookingDetail.bookingDetailFormDtos[0]
                                  .detailServiceDtos[index].serviceName,
                              maxLines: null,
                              style: GoogleFonts.roboto(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: size.height * 0.005,
                    ),
                    itemCount: bookingDetail
                        .bookingDetailFormDtos[0].detailServiceDtos.length),
              ],
            ),
          ),
        ),
      );
    },
  );
}
