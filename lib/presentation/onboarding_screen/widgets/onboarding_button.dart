import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

Widget renderNextBtn() {
  return const Icon(
    Icons.arrow_forward,
    color: Colors.black,
  );
}

Widget renderDoneBtn(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Text(
    'Bắt Đầu',
    style: GoogleFonts.roboto(
      color: Colors.black,
      fontSize: size.height * 0.02,
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget renderSkipBtn(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Text(
    'Bỏ qua',
    style: GoogleFonts.roboto(
      color: Colors.black,
      fontSize: size.height * 0.02,
      fontWeight: FontWeight.w600,
    ),
  );
}
