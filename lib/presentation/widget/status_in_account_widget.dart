import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/color_constant.dart';


Widget statusInAccountWidget(BuildContext context, String status){
  var size = MediaQuery.of(context).size;
  if(status == "PENDING"){

    return Container(
      padding: EdgeInsets.only(
        left: size.width * 0.03,
        right: size.width * 0.03,
        top: size.height * 0.005,
        bottom: size.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: Colors.yellow.withOpacity(0.2),
        borderRadius: BorderRadius.circular(size.height * 0.01),
      ),
      child: Text(
        "Đang chờ xét duyệt",
        style: GoogleFonts.roboto(
          color: Colors.yellow,
          fontSize: size.height * 0.018,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }else if(status == "ACTIVATE"){
    return Container(
      padding: EdgeInsets.only(
        left: size.width * 0.03,
        right: size.width * 0.03,
        top: size.height * 0.005,
        bottom: size.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(size.height * 0.01),
      ),
      child: Text(
        "Đang hoạt động",
        style: GoogleFonts.roboto(
          color: ColorConstant.primaryColor,
          fontSize: size.height * 0.018,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }else if(status == "REJECTED"){
    return Container(
      padding: EdgeInsets.only(
        left: size.width * 0.03,
        right: size.width * 0.03,
        top: size.height * 0.005,
        bottom: size.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.redFail.withOpacity(0.2),
        borderRadius: BorderRadius.circular(size.height * 0.01),
      ),
      child: Text(
        "Đã bị từ chối",
        style: GoogleFonts.roboto(
          color: ColorConstant.redFail,
          fontSize: size.height * 0.018,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }else{
    return const SizedBox();
  }
}