import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/color_constant.dart';
import 'package:intl/intl.dart';
import 'package:elssit/core/models/certification_models/certification_all_data_model.dart';

Widget certificationItem(
    BuildContext context, CertificationAllDataModel certification) {
  var size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.all(size.width * 0.05),
    width: size.width,
    height: size.height * 0.16,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(18.5)),
      border: Border.all(
        color: ColorConstant.whiteE3,
        width: 2,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.67,
              child: Text(
                certification.title,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: GoogleFonts.roboto(
                  color: ColorConstant.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.024,
                ),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.more_horiz,
              size: size.height * 0.03,
              color: ColorConstant.primaryColor,
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: size.height * 0.01)),
        Text(
          "Tổ chức: ${certification.organization}",
          style: GoogleFonts.roboto(
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.w400,
            fontSize: size.height * 0.022,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: size.height * 0.01)),
        SizedBox(
          width: size.width * 0.9,
          child: Text(
            "Ngày nhận: ${DateFormat("dd - MM - yyyy").format(certification.dateReceived)}",
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: GoogleFonts.roboto(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w400,
              fontSize: size.height * 0.022,
            ),
          ),
        ),
      ],
    ),
  );
}
