import 'package:elssit/core/models/booking_models/booking_history_data_model.dart';
import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/presentation/loading_screen/loading_screen.dart';
import 'package:elssit/presentation/note_screen/screen/note_screen.dart';
import 'package:elssit/presentation/splash_screen/splash_screen.dart';
import 'package:elssit/presentation/timeline_tracking/bloc/timeline_tracking_bloc.dart';
import 'package:elssit/presentation/timeline_tracking/bloc/timeline_tracking_event.dart';
import 'package:elssit/presentation/timeline_tracking/bloc/timeline_tracking_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:permission_handler/permission_handler.dart' as perMiss;

class TimeLineTrackingScreen extends StatefulWidget {
  TimeLineTrackingScreen({super.key, required this.booking});
  BookingHistoryDataModel booking;

  @override
  State<TimeLineTrackingScreen> createState() =>
      _TimeLineTrackingScreenState(booking: booking);
}

class _TimeLineTrackingScreenState extends State<TimeLineTrackingScreen> {
  _TimeLineTrackingScreenState({required this.booking});
  BookingHistoryDataModel booking;

  final timelineBloc = TimelineBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timelineBloc.idBooking = booking.id;
    timelineBloc.modelBooking = booking;
    timelineBloc.lat = booking.latitude;
    timelineBloc.lng = booking.longitude;
    timelineBloc.eventController.sink.add(FetchTimelineEvent(context: context));
  }

  handlePermission(BuildContext context) async {
    // await testRequestLocationPermission();
    perMiss.PermissionStatus permisstionCheck =
        await perMiss.Permission.location.status;
    if (permisstionCheck == perMiss.PermissionStatus.granted) {
    } else {
      QuickAlert.show(
        context: context,
        title: "Quyền truy cập vị trí chưa bật",
        text: "Để thực hiện việc check in cần phải bật quyền truy cập vị trí",
        type: QuickAlertType.warning,
        confirmBtnText: "OK",
        onConfirmBtnTap: () async {
          Navigator.pop(context);
          await testRequestLocationPermission(context);
        },
        cancelBtnText: "Huỷ",
        showCancelBtn: true,
        onCancelBtnTap: () {
          Navigator.pop(context);
        },
      );
    }
  }

  Future<void> testRequestLocationPermission(BuildContext context) async {
    perMiss.PermissionStatus locationStatus =
        await perMiss.Permission.location.request();
    if (locationStatus != perMiss.PermissionStatus.granted) {
//Show thông báo

      if (locationStatus == perMiss.PermissionStatus.denied) {
        await QuickAlert.show(
            title: "Quyền truy cập vị trí",
            text:
                "Chúng tôi cần xác định bạn đã đến đúng điểm làm việc hay chưa",
            context: context,
            type: QuickAlertType.warning,
            confirmBtnText: "OK",
            onConfirmBtnTap: () async {
              Navigator.pop(context);
              await perMiss.Permission.location.request();
            },
            onCancelBtnTap: () {
              Navigator.pop(context);
            },
            showCancelBtn: true);
      } else if (locationStatus == perMiss.PermissionStatus.permanentlyDenied) {
        //Show thông báo Bị từ chối vĩnh viễn
        await QuickAlert.show(
            title: "Quyền vị trí đã bị tắt vĩnh viễn",
            text: "1. Mở cài đặt ứng dụng"
                "\n"
                "2. Chọn ứng dụng Elsit"
                "\n"
                "3. Chọn quản lý quyền"
                "\n"
                "4. Chọn quyền vị trí và bật",
            context: context,
            type: QuickAlertType.warning,
            onConfirmBtnTap: () async {
              Navigator.pop(context);
              await perMiss.openAppSettings();
            },
            onCancelBtnTap: () {
              Navigator.pop(context);
            },
            showCancelBtn: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: timelineBloc.stateController.stream,
        initialData: InitTimelineState(),
        builder: (context, snapshot) {
          if (snapshot.data is InitTimelineState) {
            return LoadingScreen();
          }
          if (snapshot.data is OtherTimelineState) {}
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
              // automaticallyImplyLeading: false,
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Lịch trình",
                ),
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: size.height * 0.028,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            bottomNavigationBar: (snapshot.data as OtherTimelineState).isLoading
                ? Container(
                    color: ColorConstant.primaryColor,
                    width: size.width,
                    height: size.height * 0.05,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  )
                : timelineBloc.statusCheckIn == "CHECK_IN"
                    ? ElevatedButton(
                        onPressed: () async {
                          await handlePermission(context);
                          perMiss.PermissionStatus permisstionCheck =
                              await perMiss.Permission.location.status;
                          if (permisstionCheck ==
                              perMiss.PermissionStatus.granted) {
                            timelineBloc.stateController.sink
                                .add(OtherTimelineState(isLoading: true));
                            Position locationCurrent =
                                await Geolocator.getCurrentPosition();
                            timelineBloc.eventController.sink.add(
                              SaveCheckInTimeLineEvent(
                                  context: context,
                                  position: locationCurrent,
                                  idBooking: booking.id),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
                          textStyle: TextStyle(
                            fontSize: size.width * 0.045,
                          ),
                        ),
                        child: Text("Bắt đầu làm việc"),
                      )
                    : timelineBloc.statusCheckIn == "CHECK_OUT"
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02),
                            width: size.width,
                            height: size.height * 0.1,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        timelineBloc.eventController.sink.add(
                                          SaveCheckOutTimeLineEvent(
                                            context: context,
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ColorConstant.primaryColor,
                                        // shape: RoundedRectangleBorder(
                                        //   borderRadius: BorderRadius.circular(size.height * 0.03),
                                        // ),
                                        textStyle: TextStyle(
                                          fontSize: size.width * 0.045,
                                        ),
                                      ),
                                      child: Text(
                                        "Kết thúc làm việc",
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: size.height * 0.02,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NoteScreen(
                                                timlineBloc: timelineBloc,
                                              ),
                                            ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber.shade600,
                                        // shape: RoundedRectangleBorder(
                                        //   borderRadius: BorderRadius.circular(size.height * 0.03),
                                        // ),
                                        textStyle: TextStyle(
                                          fontSize: size.width * 0.045,
                                        ),
                                      ),
                                      child: Text(
                                        "Ghi chú",
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: size.height * 0.02,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          )
                        : null,
            body: timelineBloc.listTimeLine.isEmpty
                ? Text("Chưa có dữ liệu")
                : SingleChildScrollView(
                    primary: true,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                              left: size.width * 0.02,
                              right: size.width * 0.02,
                              top: size.height * 0.02,
                            ),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Card(
                              child: ExpansionTile(
                                  title: Text(
                                    '${timelineBloc.listTimeLine[index].date}',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  children: [
                                    timelineBloc.listTimeLine[index]
                                            .trackingDtoList.isEmpty
                                        ? Text("Chưa có dữ liệu")
                                        : ListView.builder(
                                            itemCount: timelineBloc
                                                .listTimeLine[index]
                                                .trackingDtoList
                                                .length,
                                            scrollDirection: Axis.vertical,
                                            padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              right: size.width * 0.02,
                                              top: size.height * 0.02,
                                            ),
                                            physics:
                                                const BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index1) =>
                                                Column(
                                              children: [
                                                Container(
                                                  color: Colors.white,
                                                  child: TimelineTile(
                                                    alignment:
                                                        TimelineAlign.end,
                                                    isFirst: true,
                                                    startChild: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                        minHeight: 80,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              "- " +
                                                                  timelineBloc
                                                                      .listTimeLine[
                                                                          index]
                                                                      .trackingDtoList[
                                                                          index1]
                                                                      .time,
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    size.height *
                                                                        0.02,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "Ghi chú: ${timelineBloc.listTimeLine[index].trackingDtoList[index1].note}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize:
                                                                    size.height *
                                                                        0.02,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                timelineBloc
                                                        .listTimeLine[index]
                                                        .trackingDtoList[index1]
                                                        .image
                                                        .isNotEmpty
                                                    ? Container(
                                                        color: Colors.white,
                                                        child: TimelineTile(
                                                          alignment:
                                                              TimelineAlign.end,
                                                          isFirst: true,
                                                          startChild: Container(
                                                              height:
                                                                  size.height *
                                                                      0.02,
                                                              width:
                                                                  size.width *
                                                                      0.3,
                                                              constraints:
                                                                  const BoxConstraints(
                                                                minHeight: 120,
                                                              ),
                                                              color: Colors
                                                                  .blueGrey,
                                                              child:
                                                                  Image.network(
                                                                timelineBloc
                                                                    .listTimeLine[
                                                                        index]
                                                                    .trackingDtoList[
                                                                        index1]
                                                                    .image,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                        ),
                                                      )
                                                    : SizedBox.shrink(),
                                              ],
                                            ),
                                          )
                                  ]),
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: size.height * 0.02,
                            ),
                            itemCount: timelineBloc.listTimeLine.length,
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
