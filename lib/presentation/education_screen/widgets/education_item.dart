import 'package:elssit/core/models/education_models/education_all_data_model.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/color_constant.dart';

Widget educationItem(BuildContext context, EducationAllDataModel education) {
  var size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.all(size.width * 0.05),
    width: size.width,
    height: size.height * 0.13,
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
            Text(
              education.educationLevel,
              style: GoogleFonts.roboto(
                color: ColorConstant.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: size.height * 0.024,
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
        Padding(padding: EdgeInsets.only(top: size.height * 0.015)),
        Text(
          "Trường: ${education.schoolName}",
          style: GoogleFonts.roboto(
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.w400,
            fontSize: size.height * 0.022,
          ),
        ),
      ],
    ),
  );
}
