import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:elssit/core/models/certification_models/certification_detail_model.dart';
import 'package:elssit/core/utils/my_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elssit/core/utils/color_constant.dart';
import 'package:image_picker/image_picker.dart';

import 'package:elssit/process/bloc/certification_bloc.dart';
import 'package:elssit/process/event/certification_event.dart';
import 'package:elssit/process/state/certification_state.dart';

import 'package:elssit/core/utils/globals.dart' as globals;

class CertificationDetailScreen extends StatefulWidget {
  const CertificationDetailScreen({Key? key, required this.certificationID})
      : super(key: key);
  final String certificationID;

  @override
  State<CertificationDetailScreen> createState() =>
      _CertificationDetailScreenState(certificationID: certificationID);
}

class _CertificationDetailScreenState extends State<CertificationDetailScreen> {
  _CertificationDetailScreenState({required this.certificationID});
  final String certificationID;
  TextEditingController dateInput = TextEditingController();
  final _certificationBloc = CertificationBloc();

  late var titleController = TextEditingController();
  late var organizationController = TextEditingController();
  late var credentialIDController = TextEditingController();
  late var credentialURLController = TextEditingController();

  // Certification Img
  String certificationImg = "";
  late File imageFileCertificationImg;
  XFile? pickedFileCertificationImg;
  UploadTask? uploadTaskCertificationImg;
  bool isCertificationImgCheck = false;

  _getEducationImageFromGallery() async {
    pickedFileCertificationImg = (await ImagePicker().pickImage(
      source: ImageSource.camera,
    ));
    if (pickedFileCertificationImg != null) {
      setState(() {
        imageFileCertificationImg = File(pickedFileCertificationImg!.path);
      });
    }
    isCertificationImgCheck = true;
    final path = 'els_sitter_images/${pickedFileCertificationImg!.name}';
    final file = File(pickedFileCertificationImg!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTaskCertificationImg = ref.putFile(file);

    final snapshot = await uploadTaskCertificationImg!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    certificationImg = urlDownload;
    _certificationBloc.eventController.sink
        .add(CertificationImgEvent(certificationImg: certificationImg));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _certificationBloc.eventController.sink
        .add(GetCertificationDetailDataEvent(certificationID: certificationID));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return StreamBuilder<CertificationState>(
        stream: _certificationBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is CertificationDetailState) {
              CertificationDetailModel certificationDetail =
                  (snapshot.data as CertificationDetailState).certification;
              _certificationBloc.eventController.sink.add(
                  FillTitleCertificationEvent(
                      title: certificationDetail.data.title));
              titleController =
                  TextEditingController(text: certificationDetail.data.title);
              _certificationBloc.eventController.sink.add(
                  FillOrganizationCertificationEvent(
                      organization: certificationDetail.data.organization));
              organizationController = TextEditingController(
                  text: certificationDetail.data.organization);
              _certificationBloc.eventController.sink.add(
                  ChooseReceivedDateCertificationEvent(
                      receivedDate: MyUtils().convertInputDate(
                          certificationDetail.data.dateReceived)));
              _certificationBloc.eventController.sink.add(
                  FillCredentialIDCertificationEvent(
                      credentialID: certificationDetail.data.credentialID));
              credentialIDController = TextEditingController(
                  text: certificationDetail.data.credentialID);

              _certificationBloc.eventController.sink.add(
                  FillCredentialURLCertificationEvent(
                      credentialURL: certificationDetail.data.credentialURL));
              credentialURLController = TextEditingController(
                  text: certificationDetail.data.credentialURL);
              certificationImg = certificationDetail.data.certificationImg;
              _certificationBloc.eventController.sink
                  .add(CertificationOtherEvent());
            }
          }
          return Material(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                bottomOpacity: 0.0,
                elevation: 0.0,
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      size: size.height * 0.03,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _certificationBloc.eventController.sink.add(
                          DeleteCertificationEvent(
                              certificationID: certificationID,
                              context: context));
                    },
                  ),
                ],
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: size.height * 0.03,
                    color: Colors.black,
                  ),
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.005),
                  child: const Text("Chứng Nhận & Giấy Phép"),
                ),
                titleTextStyle: GoogleFonts.roboto(
                  fontSize: size.height * 0.028,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              body: Container(
                color: Colors.white,
                height: size.height,
                width: size.width,
                padding: EdgeInsets.only(
                  left: size.width * 0.07,
                  right: size.width * 0.07,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tiêu đề',
                          style: GoogleFonts.roboto(
                            color: ColorConstant.gray43,
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.02,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.whiteF3,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Theme(
                          data: theme.copyWith(
                            colorScheme: theme.colorScheme
                                .copyWith(primary: ColorConstant.primaryColor),
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            cursorColor: ColorConstant.primaryColor,
                            controller: titleController,
                            onChanged: (value) {
                              _certificationBloc.eventController.sink.add(
                                  FillTitleCertificationEvent(
                                      title: value.toString().trim()));
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: size.width * 0.04,
                              ),
                              hintText: "Tiêu đề của chứng nhận",
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      (snapshot.hasError &&
                              (snapshot.error as Map<String, String>)
                                  .containsKey("title"))
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                (snapshot.error
                                    as Map<String, String>)["title"]!,
                                style: TextStyle(
                                  color: ColorConstant.redFail,
                                  fontSize: size.height * 0.017,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Đơn vị phát hành',
                          style: GoogleFonts.roboto(
                            color: ColorConstant.gray43,
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.02,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.whiteF3,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Theme(
                          data: theme.copyWith(
                            colorScheme: theme.colorScheme
                                .copyWith(primary: ColorConstant.primaryColor),
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            cursorColor: ColorConstant.primaryColor,
                            controller: organizationController,
                            onChanged: (value) {
                              _certificationBloc.eventController.sink.add(
                                  FillOrganizationCertificationEvent(
                                      organization: value.toString().trim()));
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: size.width * 0.04,
                              ),
                              hintText: "Đơn vị cấp chứng nhận",
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      (snapshot.hasError &&
                              (snapshot.error as Map<String, String>)
                                  .containsKey("organization"))
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                (snapshot.error
                                    as Map<String, String>)["organization"]!,
                                style: TextStyle(
                                  color: ColorConstant.redFail,
                                  fontSize: size.height * 0.017,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ngày nhận giải thưởng',
                          style: GoogleFonts.roboto(
                            color: ColorConstant.gray43,
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.02,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.02,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              DatePicker.showDatePicker(context,
                                  //showDateTime to pick time
                                  showTitleActions: true,
                                  minTime: DateTime(1950, 1, 1),
                                  maxTime: DateTime.now(),
                                  onChanged: (date) {}, onConfirm: (date) {
                                String dateInput =
                                    '${(date.day >= 10) ? date.day : '0${date.day}'}-${(date.month >= 10) ? date.month : '0${date.month}'}-${date.year}';
                                _certificationBloc.eventController.sink.add(
                                    ChooseReceivedDateCertificationEvent(
                                        receivedDate: dateInput));
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.vi);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorConstant.whiteF3,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black),
                                cursorColor: ColorConstant.primaryColor,
                                controller: (snapshot.data
                                        is DateReceivedCertificationState)
                                    ? (snapshot.data
                                            as DateReceivedCertificationState)
                                        .dateReceivedController
                                    : null,
                                enabled: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: size.width * 0.04,
                                  ),
                                  labelStyle: GoogleFonts.roboto(
                                    color: Colors.black,
                                  ),
                                  labelText: 'Ngày nhận giải thưởng',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: ColorConstant.primaryColor,
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        right: size.width * 0.03),
                                    child: Icon(
                                      Icons.arrow_drop_down_sharp,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                  suffixIconConstraints: BoxConstraints(
                                      minHeight: size.width * 0.06,
                                      minWidth: size.width * 0.06),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      (snapshot.hasError &&
                              (snapshot.error as Map<String, String>)
                                  .containsKey("time"))
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                (snapshot.error
                                    as Map<String, String>)["time"]!,
                                style: TextStyle(
                                  color: ColorConstant.redFail,
                                  fontSize: size.height * 0.017,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ID xác thực (không bắt buộc)',
                          style: GoogleFonts.roboto(
                            color: ColorConstant.gray43,
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.02,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.whiteF3,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Theme(
                          data: theme.copyWith(
                            colorScheme: theme.colorScheme
                                .copyWith(primary: ColorConstant.primaryColor),
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            cursorColor: ColorConstant.primaryColor,
                            controller: credentialIDController,
                            onChanged: (value) {
                              _certificationBloc.eventController.sink.add(
                                  FillCredentialIDCertificationEvent(
                                      credentialID: value.toString().trim()));
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: size.width * 0.04,
                              ),
                              hintText: "....",
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'URL xác thực (không bắt buộc)',
                          style: GoogleFonts.roboto(
                            color: ColorConstant.gray43,
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.02,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.whiteF3,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Theme(
                          data: theme.copyWith(
                            colorScheme: theme.colorScheme
                                .copyWith(primary: ColorConstant.primaryColor),
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            cursorColor: ColorConstant.primaryColor,
                            controller: credentialURLController,
                            onChanged: (value) {
                              _certificationBloc.eventController.sink.add(
                                  FillCredentialURLCertificationEvent(
                                      credentialURL: value.toString().trim()));
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: size.width * 0.04,
                              ),
                              hintText: "....",
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Chứng chỉ',
                          style: GoogleFonts.roboto(
                            color: ColorConstant.gray43,
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.02,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      (!isCertificationImgCheck)
                          ? DottedBorder(
                              color: Colors.grey.withOpacity(0.3),
                              dashPattern: const [12, 8],
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(size.height * 0.02),
                              padding: const EdgeInsets.all(0),
                              borderPadding: const EdgeInsets.all(0),
                              child: Container(
                                width: size.width,
                                height: size.height * 0.2,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.15),
                                  image: DecorationImage(
                                    image: NetworkImage(certificationImg),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(size.height * 0.02),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    _getEducationImageFromGallery();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.upload_file_rounded,
                                        color: ColorConstant.primaryColor
                                            .withOpacity(0.8),
                                        size: size.height * 0.05,
                                      ),
                                      const Text("Tải tệp lên"),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : DottedBorder(
                              color: Colors.grey.withOpacity(0.3),
                              dashPattern: const [12, 8],
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(size.height * 0.02),
                              padding: const EdgeInsets.all(0),
                              borderPadding: const EdgeInsets.all(0),
                              child: Container(
                                width: size.width,
                                height: size.height * 0.2,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.15),
                                  image: DecorationImage(
                                    image: NetworkImage(certificationImg),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(size.height * 0.02),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    _getEducationImageFromGallery();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.upload_file_rounded,
                                        color: ColorConstant.primaryColor
                                            .withOpacity(0.8),
                                        size: size.height * 0.05,
                                      ),
                                      const Text("Tải tệp lên"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      (snapshot.hasError &&
                              (snapshot.error as Map<String, String>)
                                  .containsKey("certificationImg"))
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                (snapshot.error as Map<String, String>)[
                                    "certificationImg"]!,
                                style: TextStyle(
                                  color: ColorConstant.redFail,
                                  fontSize: size.height * 0.017,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Container(
                        height: 1,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          color: ColorConstant.whiteEE,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: size.height * 0.07,
                        child: ElevatedButton(
                          onPressed: () {
                            _certificationBloc.eventController.sink.add(
                                UpdateCertificationEvent(
                                    certificationID: certificationID,
                                    context: context));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side:
                                  BorderSide(color: ColorConstant.primaryColor),
                            ),
                            backgroundColor: ColorConstant.primaryColor,
                            textStyle: TextStyle(
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          child: const Text("Lưu"),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
