import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elssit/core/utils/color_constant.dart';
import '../../../core/utils/my_enum.dart';
import 'package:elssit/process/bloc/cancel_booking_bloc.dart';
import 'package:elssit/process/event/cancel_booking_event.dart';

StatefulWidget cancelBookingContentWidget(
    BuildContext context,
    String title,
    CancelBookingBloc cancelBookingBloc,
    InfoBookingType infoBookingType,
    CancelBookingType cancelBookingType) {
  var size = MediaQuery.of(context).size;
  if (title == 'Gói dịch vụ không phù hợp') {
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
                title: const Text('Công việc vượt ngoài khả năng'),
                leading: Radio<InfoBookingType>(
                  value: InfoBookingType.address,
                  groupValue: infoBookingType,
                  onChanged: (InfoBookingType? value) {
                    setState(() {
                      cancelBookingBloc.eventController.sink.add(
                          ChooseInfoBookingContentCancelBookingEvent(
                              content: "Công việc vượt ngoài khả năng",
                              infoBookingType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Người cao tuổi không phù hợp'),
                leading: Radio<InfoBookingType>(
                  value: InfoBookingType.elder,
                  groupValue: infoBookingType,
                  onChanged: (InfoBookingType? value) {
                    setState(() {
                      cancelBookingBloc.eventController.sink.add(
                          ChooseInfoBookingContentCancelBookingEvent(
                              content: "Người cao tuổi không phù hợp",
                              infoBookingType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Thay đổi gói'),
                leading: Radio<InfoBookingType>(
                  value: InfoBookingType.package,
                  groupValue: infoBookingType,
                  onChanged: (InfoBookingType? value) {
                    setState(() {
                      cancelBookingBloc.eventController.sink.add(
                          ChooseInfoBookingContentCancelBookingEvent(
                              content: "Thay đổi gói",
                              infoBookingType: value!));
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  } else if (title == 'Vấn đề về thời gian') {
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
                title: const Text('Có việc bận'),
                leading: Radio<CancelBookingType>(
                  value: CancelBookingType.time,
                  groupValue: cancelBookingType,
                  onChanged: (CancelBookingType? value) {
                    setState(() {
                      cancelBookingBloc.eventController.sink.add(
                          ChooseTyeCancelBookingEvent(
                              content: "Có việc bận",
                              cancelBookingType: value!));
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Không muốn đặt nữa'),
                leading: Radio<CancelBookingType>(
                  value: CancelBookingType.cancel,
                  groupValue: cancelBookingType,
                  onChanged: (CancelBookingType? value) {
                    setState(() {
                      cancelBookingBloc.eventController.sink.add(
                          ChooseTyeCancelBookingEvent(
                              content: "Không muốn đặt nữa",
                              cancelBookingType: value!));
                    });
                  },
                ),
              ),
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
            cancelBookingBloc.eventController.sink
                .add(FillContentCancelBookingEvent(content: value.toString()));
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: size.width * 0.04,
              right: size.width * 0.04,
              top: size.height * 0.04,
            ),
            filled: true,
            fillColor: Colors.white,
            labelStyle: GoogleFonts.roboto(
              color: ColorConstant.whiteEE,
            ),
            hintText: "Nội dung Phản Hồi",
            //labelText: 'Chi tiết: ',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 1, color: ColorConstant.whiteEE),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
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
