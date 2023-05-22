import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elssit/core/utils/my_enum.dart';
import 'package:elssit/presentation/cancel_booking_screen/widgets/cancel_booking_content_widget.dart';
import 'package:elssit/presentation/cancel_booking_screen/widgets/confirm_cancel_booking_dialog.dart';
import 'package:elssit/process/bloc/cancel_booking_bloc.dart';
import 'package:elssit/process/event/cancel_booking_event.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elssit/core/utils/color_constant.dart';
import '../../process/state/cancel_booking_state.dart';

class CancelBookingScreen extends StatefulWidget {
  const CancelBookingScreen({Key? key, required this.bookingID})
      : super(key: key);
  final String bookingID;

  @override
  State<CancelBookingScreen> createState() =>
      // ignore: no_logic_in_create_state
      _CancelBookingScreenState(bookingID: bookingID);
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  _CancelBookingScreenState({required this.bookingID});

  final String bookingID;
  String title = "Khác";
  final List<String> titleItems = [
    'Gói dịch vụ không phù hợp',
    'Vấn đề về thời gian',
    'Khác',
  ];
  InfoBookingType _infoBookingType = InfoBookingType.address;
  CancelBookingType _cancelBookingType = CancelBookingType.time;
  final cancelBookingBloc = CancelBookingBloc();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: cancelBookingBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is ChooseInfoBookingCancelBookingState) {
              _infoBookingType =
                  (snapshot.data as ChooseInfoBookingCancelBookingState)
                      .infoBookingType;
              cancelBookingBloc.eventController.sink
                  .add(OtherCancelBookingEvent());
            }
            if (snapshot.data is ChooseTypeCancelBookingState) {
              _cancelBookingType =
                  (snapshot.data as ChooseTypeCancelBookingState)
                      .cancelBookingType;
              cancelBookingBloc.eventController.sink
                  .add(OtherCancelBookingEvent());
            }
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              bottomOpacity: 0,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_outlined,
                  size: size.height * 0.03,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Padding(
                padding: EdgeInsets.only(left: size.width * 0.06),
                child: const Text(
                  "Xác Nhận Hủy Lịch trình",
                ),
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: size.height * 0.024,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              color: Colors.white,
              width: size.width,
              height: size.height * 0.12,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      showConfirmCancelBookingDialog(
                          context, cancelBookingBloc, bookingID);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size.height * 0.03),
                      ),
                      textStyle: TextStyle(
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    child: const Text("Xác nhận"),
                  ),
                ),
              ),
            ),
            body: Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.005,
                        //left: size.width * 0.06,
                        //right: size.width * 0.05,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Lý do bạn muốn từ chối',
                          style: GoogleFonts.roboto(
                            color: ColorConstant.primaryColor,
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                      ),
                      child: DropdownButtonFormField2(
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
                          //labelText: 'vấn đề: ',
                          errorText: (snapshot.hasError &&
                                  (snapshot.error as Map<String, String>)
                                      .containsKey("title"))
                              ? (snapshot.error as Map<String, String>)["title"]
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                width: 1, color: ColorConstant.whiteEE),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                        hint: const Text(
                          'Vấn đề muốn Phản Hồi',
                          style: TextStyle(fontSize: 14),
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.grey,
                        ),
                        iconSize: size.width * 0.06,
                        buttonHeight: size.height * 0.07,
                        buttonPadding: const EdgeInsets.all(0),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        value: title,
                        items: titleItems
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: GoogleFonts.roboto(
                                    fontSize: size.height * 0.022,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            title = value.toString();
                          });
                          cancelBookingBloc.eventController.sink.add(
                              ChooseTitleCancelBookingEvent(
                                  title: value.toString()));
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                      ),
                      child: cancelBookingContentWidget(
                          context,
                          title,
                          cancelBookingBloc,
                          _infoBookingType,
                          _cancelBookingType),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
