import 'package:elssit/core/models/package_service_models/package_service_all_data_model.dart';
import 'package:elssit/core/models/package_service_models/package_service_detail_data_model.dart';
import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/presentation/loading_screen/loading_screen.dart';
import 'package:elssit/process/bloc/package_bloc.dart';
import 'package:elssit/process/event/package_event.dart';
import 'package:elssit/process/state/package_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({Key? key, required this.packageServiceID})
      : super(key: key);
  final String packageServiceID;
  @override
  State<ServiceDetailScreen> createState() =>
      _ServiceDetailScreenState(packageServiceID: packageServiceID);
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  _ServiceDetailScreenState({required this.packageServiceID});
  final String packageServiceID;
  final packageServiceDetailBloc = PackageBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    packageServiceDetailBloc.eventController.sink
        .add(GetPackageServiceDetailEvent(packageServiceID: packageServiceID));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    PackageServiceDetailDataModel? packageDetail;
    return StreamBuilder<Object>(
      stream: packageServiceDetailBloc.stateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is GetPackageServiceDetailState) {
            packageDetail =
                (snapshot.data as GetPackageServiceDetailState).packageDetail;
          }
          if (packageDetail != null) {
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
                    "Chi tiết gói dịch vụ",
                  ),
                ),
                titleTextStyle: GoogleFonts.roboto(
                  fontSize: size.height * 0.028,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              body: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    ListView.builder(
                      padding: EdgeInsets.only(
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                        //top: size.height * 0.03,
                      ),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: packageDetail!.serviceDtos.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 12,
                              backgroundColor: Color(0xFFF1F9F1),
                              child: Icon(
                                Icons.done,
                                size: 17,
                                color: Color(0xFF5CB85C),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: size.width * 0.75,
                              child: Text(
                                packageDetail!.serviceDtos[index].name,
                                maxLines: null,
                                style: GoogleFonts.roboto(
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //),
              ),
            );
          } else {
            return const LoadingScreen();
          }
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
