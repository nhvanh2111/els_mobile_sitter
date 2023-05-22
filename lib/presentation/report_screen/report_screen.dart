import 'package:elssit/core/models/report_models/report_all_model.dart';
import 'package:elssit/presentation/loading_screen/loading_screen.dart';
import 'package:elssit/presentation/report_screen/widgets/report_item.dart';
import 'package:elssit/presentation/widget/booking_empty.dart';
import 'package:elssit/process/bloc/report_bloc.dart';
import 'package:elssit/process/event/report_event.dart';
import 'package:elssit/process/state/report_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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
    return StreamBuilder<ReportState>(
        stream: _reportBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is GetAllReportState) {
              reportList = (snapshot.data as GetAllReportState).reportList;
            }
          }
          if (reportList != null) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
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
                title: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Lịch sử Phản Hồi",
                  ),
                ),
                titleTextStyle: GoogleFonts.roboto(
                  fontSize: size.height * 0.028,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              body: Material(
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
                        (reportList!.data.isEmpty)
                            ? bookingEmptyWidget(context, "Chưa có dữ liệu")
                            : ListView.separated(
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.only(
                                  left: size.width * 0.05,
                                  right: size.width * 0.05,
                                  top: size.height * 0.03,
                                ),
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, '/serviceDetailScreen');
                                  },
                                  child: reportItem(
                                      context, reportList!.data[index]),
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
              ),
            );
          } else {
            return const LoadingScreen();
          }
        });
  }
}
