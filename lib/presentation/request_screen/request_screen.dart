import 'package:elssit/core/utils/image_constant.dart';
import 'package:elssit/presentation/loading_screen/loading_screen.dart';
import 'package:elssit/presentation/request_screen/widgets/request_detail_screen.dart';
import 'package:elssit/presentation/request_screen/widgets/request_item.dart';
import 'package:elssit/presentation/widget/booking_empty.dart';
import 'package:elssit/process/bloc/booking_bloc.dart';
import 'package:elssit/process/event/booking_event.dart';
import 'package:elssit/process/state/booking_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/models/booking_models/booking_history_model.dart';
import '../../core/utils/color_constant.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final _bookingBloc = BookingBloc();
  BookingHistoryModel? bookingWaitingList;

  @override
  void initState() {
    // _bookingBloc.stateController.add(LoadingDataState());
    _bookingBloc.eventController.sink.add(GetBookingWatingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: _bookingBloc.stateController.stream,
        initialData: LoadingDataState(),
        builder: (context, snapshot) {
          if (snapshot.data is LoadingDataState) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: ColorConstant.primaryColor, size: 50),
            );
          } else if (snapshot.data is GetWaitingBookingState) {
            bookingWaitingList =
                (snapshot.data as GetWaitingBookingState).bookingWaitingList;
          }
          if (bookingWaitingList != null) {
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: size.height * 0.08,
                elevation: 0.0,
                automaticallyImplyLeading: false,
                leading: ImageIcon(
                  AssetImage(ImageConstant.appLogo),
                  size: size.width * 0.08,
                  color: ColorConstant.primaryColor,
                ),
                backgroundColor: Colors.white,
                title: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.01,
                      bottom: size.height * 0.01,
                    ),
                    child: Text(
                      "Tiến Trình Hôm Nay",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: size.height * 0.03,
                      ),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_outlined,
                      size: size.height * 0.03,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              body: Material(
                child: Container(
                  color: Colors.white,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        (bookingWaitingList!.data.isEmpty)
                            ? bookingEmptyWidget(context, "Chưa có dữ liệu")
                            : ListView.separated(
                                padding: const EdgeInsets.all(0),
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RequestDetailScreen(
                                                  bookingID: bookingWaitingList!
                                                      .data[index].id)),
                                    );
                                  },
                                  child: requestItem(
                                      context, bookingWaitingList!.data[index]),
                                ),
                                separatorBuilder: (context, index) => Container(
                                  width: size.width,
                                  height: 1,
                                  margin: EdgeInsets.only(
                                      top: size.height * 0.01,
                                      bottom: size.height * 0.02),
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                itemCount: bookingWaitingList!.data.length,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const LoadingScreen();
          }
        });
  }
}
