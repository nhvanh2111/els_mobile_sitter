import 'package:elssit/core/models/certification_models/certification_all_model.dart';
import 'package:elssit/presentation/certification_screen/widgets/certification_detail_screen.dart';
import 'package:elssit/presentation/certification_screen/widgets/certification_item.dart';
import 'package:elssit/presentation/loading_screen/loading_screen.dart';
import 'package:elssit/presentation/widget/booking_empty.dart';
import 'package:elssit/process/bloc/certification_bloc.dart';
import 'package:elssit/process/event/certification_event.dart';
import 'package:elssit/process/state/certification_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/globals.dart' as globals;
import '../../core/utils/color_constant.dart';

class CertificationScreen extends StatefulWidget {
  const CertificationScreen({Key? key}) : super(key: key);

  @override
  State<CertificationScreen> createState() => _CertificationScreenState();
}

class _CertificationScreenState extends State<CertificationScreen> {
  final _certificationBloc = CertificationBloc();
  CertificationAllModel? listCert;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _certificationBloc.eventController.sink.add(GetAllCertificationEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<CertificationState>(
      stream: _certificationBloc.stateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is GetAllCertificationState) {
            listCert =
                (snapshot.data as GetAllCertificationState).certificationList;
            _certificationBloc.eventController.sink
                .add(CertificationOtherEvent());
          }
        }
        if (listCert != null) {
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
                  if (globals.sitterStatus == "CREATED" ||
                      globals.sitterStatus == "REJECTED") {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushNamed(context, "/accountScreen");
                  }
                },
              ),
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Chứng nhận & Giấy phép",
                ),
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: size.height * 0.024,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addNewCertificationScreen');
              },
              elevation: 0.0,
              backgroundColor: ColorConstant.primaryColor,
              child: const Icon(Icons.add),
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
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      (globals.sitterStatus == "CREATED" ||
                              globals.sitterStatus == "REJECTED")
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/workExperienceScreen");
                              },
                              child: Text(
                                "Trang tiếp theo",
                                style: GoogleFonts.roboto(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstant.primaryColor,
                                  fontSize: size.height * 0.022,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      (listCert!.data.isEmpty)
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CertificationDetailScreen(
                                                certificationID: (snapshot.data
                                                        as GetAllCertificationState)
                                                    .certificationList
                                                    .data[index]
                                                    .id),
                                      ));
                                },
                                child: certificationItem(
                                    context, (listCert!.data[index])),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: size.height * 0.02,
                              ),
                              itemCount: listCert!.data.length,
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
      },
    );
  }
}
