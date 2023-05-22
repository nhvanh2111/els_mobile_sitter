import 'package:elssit/core/utils/image_constant.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/color_constant.dart';

Widget bookingEmptyWidget(BuildContext context, String content) {
  var size = MediaQuery.of(context).size;
  return Material(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * 0.03,
        ),
        Image.asset(
          ImageConstant.icNoneBooking,
          width: size.width * 0.9,
          height: size.width * 0.9,
        ),
        // SizedBox(
        //   height: size.height * 0.02,
        // ),
        // Text(
        //   'Trống',
        //   textAlign: TextAlign.center,
        //   style: GoogleFonts.roboto(
        //     color: Colors.black,
        //     fontWeight: FontWeight.w600,
        //     fontSize: size.height * 0.04,
        //   ),
        // ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Text(
          content,
          style: GoogleFonts.roboto(
            color: ColorConstant.gray69,
            fontWeight: FontWeight.normal,
            fontSize: size.height * 0.022,
          ),
        ),
      ],
    ),
  );
}
