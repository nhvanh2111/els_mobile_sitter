import 'package:elssit/presentation/package_screen.dart/widgets/package_item.dart';
import 'package:elssit/presentation/loading_screen/loading_screen.dart';

import 'package:elssit/process/bloc/package_bloc.dart';
import 'package:elssit/process/event/package_event.dart';
import 'package:elssit/process/event/rating_event.dart';
import 'package:elssit/process/state/package_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/models/package_service_models/package_service_all_model.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/globals.dart' as globals;

class SitterPackageScreen extends StatefulWidget {
  const SitterPackageScreen({Key? key}) : super(key: key);

  @override
  State<SitterPackageScreen> createState() => _SitterPackageScreenState();
}

class _SitterPackageScreenState extends State<SitterPackageScreen> {
  final _packageBloc = PackageBloc();
  PackageServiceAllModel? packageModelHaveList;
  PackageServiceAllModel? packageModelNotHaveList;
  List<String> listPackage = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _packageBloc.eventController.sink.add(GetHavePackageEvent());
    _packageBloc.eventController.sink.add(GetNotHavePackageEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<PackageState>(
      stream: _packageBloc.stateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is GetHavePackageState) {
            packageModelHaveList =
                (snapshot.data as GetHavePackageState).packageList;
            for (var element in packageModelHaveList!.data) {
              _packageBloc.eventController.sink
                  .add(CheckPackageEvent(packageID: element.id));
              listPackage.add(element.id);
            }

            _packageBloc.eventController.sink.add(OtherPackageEvent());
          }
          if (snapshot.data is GetNotHavePackageState) {
            packageModelNotHaveList =
                (snapshot.data as GetNotHavePackageState).packageList;
          }
          if (snapshot.data is CheckPackageState) {
            listPackage = (snapshot.data as CheckPackageState).listPackage;
            print('test list : $listPackage');
          }
        }

        if (packageModelHaveList != null || packageModelNotHaveList != null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.filter_list_alt,
                    size: size.height * 0.035,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // _certificationBloc.eventController.sink.add(
                    //     DeleteCertificationEvent(
                    //         certificationID: certificationID,
                    //         context: context));
                  },
                ),
              ],
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_outlined,
                  size: size.height * 0.03,
                  color: Colors.black,
                ),
                onPressed: () {
                  if (globals.sitterStatus == "CREATED" || globals.sitterStatus == "REJECTED") {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushNamed(context, "/accountScreen");
                  }
                },
              ),
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Gói dịch vụ",
                ),
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: size.height * 0.028,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            floatingActionButton: SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.07,
              child: ElevatedButton(
                onPressed: () {
                  _packageBloc.eventController.sink.add(SaveListPackageEvent(
                      context: context, packageBloc: _packageBloc));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // <-- Radius
                  ),
                  backgroundColor: ColorConstant.primaryColor,
                  elevation: 1,
                  textStyle: TextStyle(
                    fontSize: size.height * 0.024,
                  ),
                ),
                child: const Text("Lưu"),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                          left: size.width * 0.05,
                        ),
                        child: Text(
                          "Các gói dịch vụ đã đăng ký",
                          style: GoogleFonts.roboto(
                              fontSize: size.height * 0.022,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      (packageModelHaveList == null ||
                              packageModelHaveList!.data.isEmpty)
                          ? const SizedBox()
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
                                child: packageItem(
                                    context,
                                    packageModelHaveList!.data[index],
                                    _packageBloc,
                                    listPackage),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: size.height * 0.02,
                              ),
                              itemCount: packageModelHaveList!.data.length,
                            ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.03,
                          left: size.width * 0.05,
                        ),
                        child: Text(
                          "Các gói dịch vụ chưa đăng ký",
                          style: GoogleFonts.roboto(
                              fontSize: size.height * 0.022,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      (packageModelNotHaveList == null ||
                              packageModelNotHaveList!.data.isEmpty)
                          ? const SizedBox()
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
                                child: packageItem(
                                    context,
                                    packageModelNotHaveList!.data[index],
                                    _packageBloc,
                                    listPackage),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: size.height * 0.02,
                              ),
                              itemCount: packageModelNotHaveList!.data.length,
                            ),
                      SizedBox(
                        height: size.height * 0.2,
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
