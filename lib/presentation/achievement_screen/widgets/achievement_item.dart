import 'package:elssit/core/models/achievement_models/achievement_all_data_model.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/color_constant.dart';

Widget achievementItem(
    BuildContext context, AchievementAllDataModel achievement) {
  var size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    padding: EdgeInsets.all(size.width * 0.05),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(size.height * 0.02),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              achievement.title,
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.024,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.more_horiz,
              size: size.height * 0.03,
              color: ColorConstant.gray43,
            ),
          ],
        ),
        Text(
          "Ngày nhận giải thưởng: ${achievement.dateReceived}",
          style: GoogleFonts.roboto(
            color: ColorConstant.gray43,
            fontWeight: FontWeight.w400,
            fontSize: size.height * 0.022,
          ),
        ),
        SizedBox(
          width: size.width * 0.9,
          child: Text(
            "Tổ chức: ${achievement.organization}",
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: GoogleFonts.roboto(
              color: ColorConstant.gray43,
              fontWeight: FontWeight.w400,
              fontSize: size.height * 0.022,
            ),
          ),
        ),
      ],
    ),
  );
}
