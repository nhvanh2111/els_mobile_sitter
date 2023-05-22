import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elssit/core/utils/image_constant.dart';
import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/process/bloc/cancel_booking_bloc.dart';
import 'package:elssit/process/event/cancel_booking_event.dart';

Future<void> showConfirmCancelBookingDialog(BuildContext context,
    CancelBookingBloc cancelBookingBloc, String bookingID) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageConstant.imgConfirm,
                  width: size.width * 0.64,
                  height: size.width * 0.5,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Bạn có chắc chắn ?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: ColorConstant.blue1,
                    fontWeight: FontWeight.w800,
                    fontSize: size.height * 0.035,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  "Hủy đặt lịch này.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: ColorConstant.gray4A,
                    fontWeight: FontWeight.normal,
                    fontSize: size.height * 0.022,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  children: [
                    Container(
                      width: size.width * 0.28,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        // ignore: sort_child_properties_last
                        child: Container(
                          width: size.width * 0.3,
                          alignment: Alignment.center,
                          child: Text(
                            'Hủy',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),

                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.035,
                    ),
                    Container(
                      width: size.width * 0.28,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        // ignore: sort_child_properties_last
                        child: Container(
                          width: size.width * 0.3,
                          alignment: Alignment.center,
                          child: Text(
                            'Xác nhận',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                        onPressed: () {
                          cancelBookingBloc.eventController.sink.add(
                              ConfirmCancelBookingEvent(
                                  context: context, bookingID: bookingID));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
