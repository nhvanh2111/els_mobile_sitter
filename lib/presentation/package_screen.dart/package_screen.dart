import 'package:elssit/presentation/package_screen.dart/widgets/package_item.dart';
import 'package:elssit/presentation/loading_screen/loading_screen.dart';

import 'package:elssit/process/bloc/package_bloc.dart';
import 'package:elssit/process/event/package_event.dart';
import 'package:elssit/process/state/package_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/models/package_service_models/package_service_all_model.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/globals.dart' as globals;
import '../widget/dialog/comfirm_sendform_dialog.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({Key? key}) : super(key: key);

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  final _packageBloc = PackageBloc();
  PackageServiceAllModel? packageModelList;
  List<String> listPackage = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _packageBloc.eventController.sink.add(GetAllPackageEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<PackageState>(
      stream: _packageBloc.stateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is GetAllPackageState) {
            packageModelList =
                (snapshot.data as GetAllPackageState).packageList;
          }
        }
        if (snapshot.data is CheckPackageState) {
          listPackage = (snapshot.data as CheckPackageState).listPackage;
        }
        if (packageModelList != null) {
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
                  showConfirmSendFormDialog(
                      context, "Gửi đơn đăng ký ?", _packageBloc);
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
                child: (globals.sitterStatus == "CREATED" ||
                        globals.sitterStatus == "REJECTED")
                    ? const Text("Xác nhận")
                    : const Text("Tiếp theo"),
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
                      (packageModelList!.data.isEmpty)
                          ? const Text("Chưa có dữ liệu")
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
                                    packageModelList!.data[index],
                                    _packageBloc,
                                    listPackage),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: size.height * 0.02,
                              ),
                              itemCount: packageModelList!.data.length,
                            ),
                      SizedBox(
                        height: size.height,
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
