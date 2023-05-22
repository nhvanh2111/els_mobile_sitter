import 'dart:ui';

import 'package:elssit/core/utils/image_constant.dart';
import 'package:elssit/process/bloc/checkin_checkout.dart';
import 'package:elssit/process/bloc/package_bloc.dart';
import 'package:elssit/process/event/package_event.dart';
import 'package:flutter/Material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:location/location.dart';

import '../../../core/utils/color_constant.dart';
import '../../../core/utils/my_utils.dart';
import '../../../process/event/checkin_checkout_event.dart';

Future<void> showConfirmCheckDialog(
    BuildContext context,
    String content,
    CheckinCheckOutBloc checkBloc,
    String bookingID,
    DateTime date,
    String location,Position locationCurrent,double lat,double lng) async {
  var size = MediaQuery.of(context).size;
  checkBloc.lat=locationCurrent.latitude;
  checkBloc.lng=locationCurrent.longitude;
            print("faill -${lat},${lng}");
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
                  content,
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
                          if (content == "Xác nhận bắt đầu") {
                            checkBloc.eventController.sink.add(SaveCheckInEvent(
                                context: context,
                                bookingID: bookingID,
                                startDateTime:
                                    MyUtils().convertDateToStringInput(date),
                                location: location,lat: lat,lng: lng
                                ));
                          } else if (content == "Xác nhận kết thúc") {
                            checkBloc.eventController.sink.add(
                                SaveCheckOutEvent(
                                    context: context,
                                    bookingID: bookingID,
                                    endDateTime: MyUtils()
                                        .convertDateToStringInput(date),
                                    location: location));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // actions: <Widget>[
        //   Container(
        //     width: size.width * 0.3,
        //     alignment: Alignment.center,
        //     child: TextButton(
        //       child: const Text(
        //         'Hủy',
        //         style: TextStyle(
        //           color: Colors.redAccent,
        //           fontSize: 10,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //       },
        //     ),
        //   ),
        //   Container(
        //     width: size.width * 0.3,
        //     alignment: Alignment.center,
        //     child: TextButton(
        //       child: const Text(
        //         'Xác nhận',
        //         style: TextStyle(
        //           color: Colors.blueAccent,
        //           fontSize: 10,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //       onPressed: () {
        //         if(content == "Xác nhận check-in"){
        //           checkBloc.eventController.sink.add(SaveCheckInEvent(
        //               context: context,
        //               bookingID: bookingID,
        //               startDateTime:
        //               MyUtils().convertDateToStringInput(date),
        //               location: location));
        //         }else if(content == "Xác nhận check-out"){
        //           checkBloc.eventController.sink.add(SaveCheckOutEvent(
        //               context: context,
        //               bookingID: bookingID,
        //               endDateTime:
        //               MyUtils().convertDateToStringInput(date),
        //               location: location));
        //         }

        //       },
        //     ),
        //   ),
        // ],
      );
    },
  );
}
