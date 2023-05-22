import 'package:elssit/presentation/widget/booking_empty.dart';
import 'package:flutter/Material.dart';

import '../../../core/models/report_models/report_all_model.dart';
import '../../../process/bloc/report_bloc.dart';
import '../../../process/event/report_event.dart';
import '../../../process/state/report_state.dart';
import '../../report_screen/widgets/report_item.dart';

class ReportPanel extends StatefulWidget {
  const ReportPanel({Key? key}) : super(key: key);

  @override
  State<ReportPanel> createState() => _ReportPanelState();
}

class _ReportPanelState extends State<ReportPanel> {
  final _reportBloc = ReportBloc();
  ReportAllModel? reportList;
  @override
  void initState() {
    super.initState();
    _reportBloc.eventController.sink.add(GetAllReportEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: _reportBloc.stateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is GetAllReportState) {
            reportList = (snapshot.data as GetAllReportState).reportList;
          }
        }
        return Material(
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  (reportList == null || reportList!.data.isEmpty)
                      ? bookingEmptyWidget(
                          context, "Chưa có bất kì dữ liệu nào")
                      : ListView.separated(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(
                            left: size.width * 0.05,
                            right: size.width * 0.05,
                            top: size.height * 0.03,
                          ),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(
                              //     context, '/serviceDetailScreen');
                            },
                            child: reportItem(context, reportList!.data[index]),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: size.height * 0.02,
                          ),
                          itemCount: reportList!.data.length,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
