import 'package:elssit/presentation/package_screen.dart/widgets/service_detail_screen.dart';
import 'package:elssit/process/event/package_event.dart';

import 'package:elssit/core/models/package_service_models/package_service_all_data_model.dart';
import 'package:elssit/presentation/widget/dialog/custom_checkbox.dart';

import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/color_constant.dart';
import '../../../process/bloc/package_bloc.dart';

StatefulWidget packageItem(
    BuildContext context,
    PackageServiceAllDataModel package,
    PackageBloc packageBloc,
    List<String> listPackage) {
//Widget packageItem(BuildContext context, PackageServiceAllDataModel package) {

  var size = MediaQuery.of(context).size;

  bool valueChkBox = false;
  if (listPackage.contains(package.id)) {
    valueChkBox = true;
  } else {
    valueChkBox = false;
  }
  return StatefulBuilder(
    builder: (context, setState) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   margin: EdgeInsets.only(
          //     right: size.width * 0.04,
          //   ),
          //   child: CustomCheckBox(
          //       isChecked: false,
          //       size: 30,
          //       iconSize: 20,
          //       selectedColor: ColorConstant.primaryColor,
          //       selectedIconColor: Colors.white),
          // ),
          Container(
            // margin: EdgeInsets.only(
            //   left: size.width * 0.04,
            // ),
            padding: EdgeInsets.all(size.width * 0.05),
            width: size.width * 0.89,
            height: size.height * 0.21,
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
                      width: size.width * 0.05,
                      height: size.height * 0.03,
                      child: Checkbox(
                        focusColor: ColorConstant.primaryColor,
                        checkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        value: valueChkBox,
                        onChanged: (bool? value) {
                          setState(() {
                            packageBloc.eventController.sink
                                .add(CheckPackageEvent(packageID: package.id));
                            // valueChkBox = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    SizedBox(
                      width: size.width * 0.62,
                      child: Text(
                        package.name,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceDetailScreen(
                                  packageServiceID: package.id),
                            ));
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        size: size.height * 0.03,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: size.width,
                  height: 1,
                  margin: EdgeInsets.only(
                    top: size.height * 0.025,
                    bottom: size.height * 0.025,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Thời gian dự kiến:",
                        style: GoogleFonts.roboto(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${package.duration} giờ",
                        style: GoogleFonts.roboto(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                    ]),
                Padding(padding: EdgeInsets.only(top: size.height * 0.015)),
                Row(children: [
                  Text(
                    "Giá tiền: ",
                    style: GoogleFonts.roboto(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.022,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${package.price} VNĐ",
                    style: GoogleFonts.roboto(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.022,
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      );
    },
  );
}
