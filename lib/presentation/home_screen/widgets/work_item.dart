import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/image_constant.dart';

Widget workItem(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Container(
    color: Colors.white,
    width: size.width,
    child: Row(
      children: [
        Image.asset(ImageConstant.icDot),
        SizedBox(
          width: size.width * 0.03,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width*0.4,
              child: Text(
                "Gói chăm sóc Lê Như",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: size.height * 0.018,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Text(
              "..............",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.02,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          "Đang tiến hành",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: size.height * 0.018,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
      ],
    ),
  );
}
