import 'dart:async';

import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/presentation/list_waiting_assign/bloc/listwaiting_bloc.dart';
import 'package:elssit/presentation/list_waiting_assign/bloc/listwaiting_state.dart';
import 'package:elssit/presentation/list_waiting_assign/bloc/listwaitting_event.dart';
import 'package:elssit/presentation/list_waiting_assign/screen/widget/item.dart';
import 'package:elssit/presentation/widget/booking_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ListWaitingAcceptScreen extends StatefulWidget {
  const ListWaitingAcceptScreen({super.key});

  @override
  State<ListWaitingAcceptScreen> createState() =>
      _ListWaitingAcceptScreenState();
}

class _ListWaitingAcceptScreenState extends State<ListWaitingAcceptScreen> {
  ListWaittingBloc wBloc = ListWaittingBloc();
  late Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wBloc.eventController.sink.add(FetchDataListWaitingEvent());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      wBloc.eventController.sink.add(FetchDataListWaitingEvent());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        title: Text(
          'Đơn hàng chờ',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<Object>(
          stream: wBloc.stateController.stream,
          initialData: InitListWaitingState(),
          builder: (context, snapshot) {
            if (snapshot.data is InitListWaitingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorConstant.primaryColor,
                ),
              );
            }
            if (snapshot.data is OtherListWaitingSate) {
              print("opk");
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  wBloc.listData.isEmpty
                      ? Center(
                          // child: Column(
                          //   mainAxisAlignment:MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       "Chưa có dữ liệu",
                          //       style: GoogleFonts.roboto(
                          //         color: Colors.black,
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 14,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          child: bookingEmptyWidget(context, "Chưa có dữ liệu"))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: wBloc.listData.length,
                          itemBuilder: (context, index) {
                            return bWItemWidget(
                                context, wBloc.listData[index], wBloc);
                            // return Container(
                            //   child: Column(
                            //     children: [
                            //       Text(wBloc.listData[index].elder.fullName),
                            //       Row(
                            //         children: [
                            //           ElevatedButton(
                            //               onPressed: () {
                            //                 wBloc.eventController.sink.add(
                            //                     AcceptListWaitingEvent(
                            //                         idBooking: wBloc
                            //                             .listData[index]
                            //                             .bookingId,
                            //                         isAcept: true));
                            //               },
                            //               child: Text("Accept")),
                            //           ElevatedButton(
                            //               onPressed: () {
                            //                 wBloc.eventController.sink.add(
                            //                     AcceptListWaitingEvent(
                            //                         idBooking: wBloc
                            //                             .listData[index]
                            //                             .bookingId,
                            //                         isAcept: false));
                            //               },
                            //               child: Text("Deny"))
                            //         ],
                            //       )
                            //     ],
                            //   ),
                            // );
                          },
                        )
                ],
              ),
            );
          }),
    );
  }
}
