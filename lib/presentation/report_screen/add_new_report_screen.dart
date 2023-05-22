import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elssit/core/utils/image_constant.dart';
import 'package:elssit/presentation/report_screen/widgets/report_content_widget.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/my_enum.dart';
import '../../process/bloc/report_bloc.dart';
import '../../process/event/report_event.dart';
import '../../process/state/report_state.dart';

// ignore: must_be_immutable
class AddNewReportScreen extends StatefulWidget {
  AddNewReportScreen(
      {Key? key, required this.bookingDetailId, required this.customerID})
      : super(key: key);
  String bookingDetailId;
  String customerID;

  @override
  State<AddNewReportScreen> createState() =>
      // ignore: no_logic_in_create_state
      _AddNewReportScreenState(
          bookingDetailId: bookingDetailId, customerID: customerID);
}

class _AddNewReportScreenState extends State<AddNewReportScreen> {
  _AddNewReportScreenState(
      {required this.bookingDetailId, required this.customerID});

  String bookingDetailId;
  String title = "Khác";
  String? content;
  String customerID;
  final reportBloc = ReportBloc();
  AttitudeType _attitudeType = AttitudeType.other;
  CusInfoType _cusInfoType = CusInfoType.other;
  final List<String> titleItems = [
    'Thái độ của khách hàng',
    'Thông tin của khách hàng',
    'Khác',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reportBloc.eventController.sink.add(ChooseTitleReportEvent(title: title));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: reportBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is ChooseAttitudeContentReportState) {
              _attitudeType =
                  (snapshot.data as ChooseAttitudeContentReportState)
                      .attitudeType;
              reportBloc.eventController.sink.add(OtherReportEvent());
            }
            if (snapshot.data is ChooseCusInfoContentReportState) {
              _cusInfoType = (snapshot.data as ChooseCusInfoContentReportState)
                  .cusInfoType;
              reportBloc.eventController.sink.add(OtherReportEvent());
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
                  "Phản Hồi Vi Phạm",
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
                      reportBloc.eventController.sink.add(ConfirmReportEvent(
                          context: context,
                          bookingDetailID: bookingDetailId,
                          customerID: customerID));
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
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        ImageConstant.imgProblem,
                        width: size.width * 0.9,
                        height: size.width * 0.8,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.005,
                        //left: size.width * 0.06,
                        //right: size.width * 0.05,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Vấn đề bạn muốn Phản Hồi ?',
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
                          reportBloc.eventController.sink.add(
                              ChooseTitleReportEvent(title: value.toString()));
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                      ),
                      child: reportContentWidget(
                        context,
                        title,
                        reportBloc,
                        _attitudeType,
                        _cusInfoType,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
