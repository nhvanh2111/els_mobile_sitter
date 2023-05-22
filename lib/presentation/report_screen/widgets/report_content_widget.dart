import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/color_constant.dart';
import '../../../core/utils/my_enum.dart';
import '../../../process/bloc/report_bloc.dart';
import '../../../process/event/report_event.dart';

StatefulWidget reportContentWidget(BuildContext context, String title,
    ReportBloc reportBloc, AttitudeType attitudeType, CusInfoType cusInfoType) {
  var size = MediaQuery.of(context).size;
  if (title == 'Thái độ của khách hàng') {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          width: size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('Không hợp tác'),
                leading: Radio<AttitudeType>(
                  value: AttitudeType.uncooperative,
                  groupValue: attitudeType,
                  onChanged: (AttitudeType? value) {
                    setState(() {
                      reportBloc.eventController.sink.add(
                          ChooseAttitudeContentReportEvent(
                              content: "Không hợp tác", attitudeType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Không thân thiện'),
                leading: Radio<AttitudeType>(
                  value: AttitudeType.unFriendly,
                  groupValue: attitudeType,
                  onChanged: (AttitudeType? value) {
                    setState(() {
                      reportBloc.eventController.sink.add(
                          ChooseAttitudeContentReportEvent(
                              content: "Không thân thiện",
                              attitudeType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Khác'),
                leading: Radio<AttitudeType>(
                  value: AttitudeType.other,
                  groupValue: attitudeType,
                  onChanged: (AttitudeType? value) {
                    setState(() {
                      reportBloc.eventController.sink.add(
                          ChooseAttitudeContentReportEvent(
                              content: "Khác", attitudeType: value!));
                    });
                  },
                ),
              ),
              (attitudeType == AttitudeType.other)
                  ? SizedBox(
                      height: size.height * 0.25,
                      child: TextField(
                        controller: null,
                        onChanged: (value) {
                          reportBloc.eventController.sink.add(
                              ChooseAttitudeContentReportEvent(
                                  content: value.toString(),
                                  attitudeType: AttitudeType.other));
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: size.width * 0.03,
                            right: size.width * 0.03,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: GoogleFonts.roboto(
                            color: Colors.black,
                          ),
                          hintText: "Nội dung Phản Hồi",
                          labelText: 'Chi tiết: ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  } else if (title == 'Thông tin của khách hàng') {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          width: size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('Thiếu thông tin'),
                leading: Radio<CusInfoType>(
                  value: CusInfoType.missing,
                  groupValue: cusInfoType,
                  onChanged: (CusInfoType? value) {
                    setState(() {
                      reportBloc.eventController.sink.add(
                          ChooseCusInfoContentReportEvent(
                              content: "Thiếu thông tin", cusInfoType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Sai thông tin'),
                leading: Radio<CusInfoType>(
                  value: CusInfoType.wrong,
                  groupValue: cusInfoType,
                  onChanged: (CusInfoType? value) {
                    setState(() {
                      reportBloc.eventController.sink.add(
                          ChooseCusInfoContentReportEvent(
                              content: "Sai thông tin", cusInfoType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Khác'),
                leading: Radio<CusInfoType>(
                  value: CusInfoType.other,
                  groupValue: cusInfoType,
                  onChanged: (CusInfoType? value) {
                    setState(() {
                      reportBloc.eventController.sink.add(
                          ChooseCusInfoContentReportEvent(
                              content: "Khác", cusInfoType: value!));
                    });
                  },
                ),
              ),
              (cusInfoType == CusInfoType.other)
                  ? SizedBox(
                      height: size.height * 0.25,
                      child: TextField(
                        onChanged: (value) {
                          reportBloc.eventController.sink.add(
                              ChooseCusInfoContentReportEvent(
                                  content: value.toString(),
                                  cusInfoType: CusInfoType.other));
                        },
                        controller: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: size.width * 0.03,
                            right: size.width * 0.03,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: GoogleFonts.roboto(
                            color: Colors.black,
                          ),
                          hintText: "Nội dung Phản Hồi",
                          labelText: 'Chi tiết: ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  } else if (title == 'Khác') {
    return StatefulBuilder(
      builder: (context, setState) => SizedBox(
        height: size.height * 0.25,
        child: TextField(
          controller: null,
          onChanged: (value) {
            reportBloc.eventController.sink.add(FillContentReportEvent(content: value.toString()));
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: size.width * 0.03,
              right: size.width * 0.03,
            ),
            filled: true,
            fillColor: Colors.white,
            labelStyle: GoogleFonts.roboto(
              color: Colors.black,
            ),
            hintText: "Nội dung Phản Hồi",
            labelText: 'Chi tiết: ',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1, color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: ColorConstant.primaryColor,
              ),
            ),
          ),
          keyboardType: TextInputType.multiline,
          maxLines: 6,
        ),
      ),
    );
  } else {
    return StatefulBuilder(
      builder: (context, setState) => const SizedBox(),
    );
  }
}
