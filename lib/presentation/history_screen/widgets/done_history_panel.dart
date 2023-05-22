import 'package:elssit/core/models/booking_models/booking_history_model.dart';
import 'package:elssit/presentation/history_screen/widgets/history_item.dart';
import 'package:elssit/presentation/loading_screen/loading_screen.dart';
import 'package:elssit/presentation/widget/booking_empty.dart';
import 'package:elssit/process/bloc/booking_bloc.dart';
import 'package:elssit/process/event/booking_event.dart';
import 'package:elssit/process/state/booking_state.dart';
import 'package:flutter/Material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/utils/color_constant.dart';

class DoneHistoryPanel extends StatefulWidget {
  const DoneHistoryPanel({Key? key}) : super(key: key);

  @override
  State<DoneHistoryPanel> createState() => _DoneHistoryPanelState();
}

class _DoneHistoryPanelState extends State<DoneHistoryPanel> {
  final _bookingBloc = BookingBloc();
  BookingHistoryModel? bookingHistoryList;

  @override
  void initState() {
    // _bookingBloc.stateController.add(LoadingDataState());
    _bookingBloc.eventController.sink
        .add(GetAllHistoryByStatusBookingEvent(status: "PAID"));
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
          } else if (snapshot.data is GetAllHistoryByStatusBookingState) {
            bookingHistoryList =
                (snapshot.data as GetAllHistoryByStatusBookingState)
                    .bookingHistoryList;
          }
          if (snapshot.hasData) {
            return Material(
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
                      (bookingHistoryList!.data.isEmpty)
                          ? bookingEmptyWidget(context, "Chưa có dữ liệu")
                          : ListView.separated(
                              padding: const EdgeInsets.all(0),
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           RequestDetailScreen(
                                  //               bookingID: bookingHistoryList!
                                  //                   .data[index].id)),
                                  // );
                                },
                                child: historyItem(
                                    context, bookingHistoryList!.data[index]),
                              ),
                              separatorBuilder: (context, index) => Container(
                                width: size.width,
                                height: 1,
                                margin: EdgeInsets.only(
                                    top: size.height * 0.01,
                                    bottom: size.height * 0.02),
                                color: Colors.black.withOpacity(0.1),
                              ),
                              itemCount: bookingHistoryList!.data.length,
                            ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return bookingEmptyWidget(context, "Chưa có dữ liệu");
          }
        });
  }
}
