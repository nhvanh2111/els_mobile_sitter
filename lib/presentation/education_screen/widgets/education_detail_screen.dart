import 'dart:io';
import 'package:elssit/core/models/education_models/education_detail_data_model.dart';
import 'package:elssit/core/models/education_models/education_detail_model.dart';
import 'package:elssit/core/utils/my_utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:elssit/core/utils/color_constant.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:elssit/process/bloc/education_bloc.dart';
import 'package:elssit/process/event/education_event.dart';
import 'package:elssit/process/state/education_state.dart';

class EducationDetailScreen extends StatefulWidget {
  const EducationDetailScreen({Key? key, required this.educationID})
      : super(key: key);
  final String educationID;

  @override
  State<EducationDetailScreen> createState() =>
      _EducationDetailScreenState(educationID: educationID);
}

class _EducationDetailScreenState extends State<EducationDetailScreen> {
  _EducationDetailScreenState({required this.educationID});

  final String educationID;
  DateTime selectedDate = DateTime.now();
  TextEditingController dateInput = TextEditingController();
  final _educationBloc = EducationBloc();

  late var schoolNameController = TextEditingController();
  late var gpaController = TextEditingController();
  late var descriptionController = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
    _educationBloc.eventController.sink
        .add(GetEducationDetailDataEvent(educationID: educationID));
  }

  bool status = false;
  final List<String> eliteracyItems = [
    'Đã tốt nghiệp THPT',
    'Đã tốt nghiệp Trung Cấp',
    'Đã tốt nghiệp Đại Học',
    'Đã tốt nghiệp Cao học',
    'Hoàn thành bằng thạc sĩ',
  ];

  final List<String> majorItems = [
    'Khác',
    'Điều dưỡng',
  ];

  String? selectedValue;
  String? majorStr;

  //Education Img
  String EducationImg = "";
  late File imageFileEducationImg;
  XFile? pickedFileEducationImg;
  UploadTask? uploadTaskEducationImg;
  bool isEducationImgCheck = false;

  _getEducationImageFromGallery() async {
    pickedFileEducationImg = (await ImagePicker().pickImage(
      source: ImageSource.camera,
    ));
    if (pickedFileEducationImg != null) {
      setState(() {
        imageFileEducationImg = File(pickedFileEducationImg!.path);
      });
    }
    isEducationImgCheck = true;
    final path = 'els_sitter_images/${pickedFileEducationImg!.name}';
    final file = File(pickedFileEducationImg!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTaskEducationImg = ref.putFile(file);

    final snapshot = await uploadTaskEducationImg!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    EducationImg = urlDownload;
    _educationBloc.eventController.sink
        .add(EducationImgSitEvent(educationImg: EducationImg));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return StreamBuilder<EducationState>(
      stream: _educationBloc.stateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is EducationDetailState) {
            EducationDetailModel educationDetail =
                (snapshot.data as EducationDetailState).education;

            _educationBloc.eventController.sink.add(
                ChooseEducationLevelEducationEvent(
                    educationLevel: educationDetail.data.educationLevel));
            selectedValue = educationDetail.data.educationLevel;

            _educationBloc.eventController.sink.add(
                ChooseMajorLevelEducationEvent(
                    major: educationDetail.data.major));
            majorStr = educationDetail.data.major;

            _educationBloc.eventController.sink.add(
                FillSchoolNameEducationEvent(
                    schoolName: educationDetail.data.schoolName));
            schoolNameController =
                TextEditingController(text: educationDetail.data.schoolName);
            // _educationBloc.eventController.sink.add(
            //     ChooseStartDateEducationEvent(
            //         startDate: MyUtils()
            //             .convertInputDate(startDate)));
            // _educationBloc.eventController.sink.add(ChooseEndDateEducationEvent(
            //     endDate:
            //         MyUtils().convertInputDate(educationDetail.data.endDate)));
            // _educationBloc.eventController.sink
            //     .add(FillGPAEducationEvent(gpa: educationDetail.data.gpa));
            // gpaController =
            //     TextEditingController(text: educationDetail.data.gpa);

            _educationBloc.eventController.sink.add(
                FillDescriptionEducationEvent(
                    description: educationDetail.data.description));
            descriptionController =
                TextEditingController(text: educationDetail.data.description);

            _educationBloc.eventController.sink.add(EducationOtherEvent());
          }
        }
        return Material(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              bottomOpacity: 0.0,
              elevation: 0.0,
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
                child: const Text(
                  "Học Vấn",
                ),
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
                        'Trình độ học vấn',
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
                      margin: EdgeInsets.only(
                        bottom: size.height * 0.01,
                      ),
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
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              top: size.height * 0.01,
                              left: size.width * 0.04,
                              right: size.width * 0.035,
                              bottom: size.height * 0.01,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
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
                          hint: const Text(
                            'Chọn trình độ học vấn',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey,
                          ),
                          iconSize: size.width * 0.06,
                          buttonHeight: size.height * 0.07,
                          buttonPadding: const EdgeInsets.all(0),
                          dropdownWidth: 310,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          items: eliteracyItems
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.roboto(
                                      fontSize: size.height * 0.02,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            _educationBloc.eventController.sink.add(
                                ChooseEducationLevelEducationEvent(
                                    educationLevel: value.toString()));
                          },
                          value: (selectedValue != null) ? selectedValue : null,
                        ),
                      ),
                    ),
                    (snapshot.hasError &&
                            (snapshot.error as Map<String, String>)
                                .containsKey("educationLevel"))
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (snapshot.error
                                  as Map<String, String>)["educationLevel"]!,
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
                        'Chuyên ngành',
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
                      margin: EdgeInsets.only(
                        bottom: size.height * 0.01,
                      ),
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
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              top: size.height * 0.01,
                              left: size.width * 0.04,
                              right: size.width * 0.035,
                              bottom: size.height * 0.01,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
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
                          hint: const Text(
                            'Chọn chuyên ngành',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey,
                          ),
                          iconSize: size.width * 0.06,
                          buttonHeight: size.height * 0.07,
                          buttonPadding: const EdgeInsets.all(0),
                          dropdownWidth: 310,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          value: majorStr,
                          items: majorItems
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.roboto(
                                      fontSize: size.height * 0.02,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            _educationBloc.eventController.sink.add(
                                ChooseMajorLevelEducationEvent(
                                    major: value.toString()));
                          },
                        ),
                      ),
                    ),
                    (snapshot.hasError &&
                            (snapshot.error as Map<String, String>)
                                .containsKey("major"))
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (snapshot.error as Map<String, String>)["major"]!,
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
                        'Trường',
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
                      margin: EdgeInsets.only(
                        bottom: size.height * 0.01,
                      ),
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
                          controller: schoolNameController,
                          onChanged: (value) {
                            _educationBloc.eventController.sink.add(
                                FillSchoolNameEducationEvent(
                                    schoolName: value.toString().trim()));
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: size.width * 0.04,
                            ),
                            hintText: "Trường",
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
                                .containsKey("school"))
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (snapshot.error
                                  as Map<String, String>)["school"]!,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Năm tốt nghiệp',
                              style: GoogleFonts.roboto(
                                color: ColorConstant.gray43,
                                fontWeight: FontWeight.w400,
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.005,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SizedBox(
                                          // Need to use container to add size constraint.
                                          width: size.width,
                                          height: size.height * 0.5,
                                          child: YearPicker(
                                            firstDate: DateTime(
                                                DateTime.now().year - 50, 1),
                                            lastDate: DateTime(
                                                DateTime.now().year, 1),
                                            initialDate: DateTime.now(),
                                            // save the selected date to _selectedDate DateTime variable.
                                            // It's used to set the previous selected date when
                                            // re-showing the dialog.
                                            selectedDate: selectedDate,
                                            onChanged: (DateTime dateTime) {
                                              // close the dialog when year is selected.
                                              setState(() {
                                                selectedDate = dateTime;
                                                _educationBloc.dateTo =
                                                    "${dateTime.year}-01-01";
                                                dateInput =
                                                    TextEditingController(
                                                        text:
                                                            "${dateTime.year}");
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstant.whiteF3,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  width: size.width * 0.4,
                                  child: TextField(
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: Colors.black),
                                    cursorColor: ColorConstant.primaryColor,
                                    controller: dateInput,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        left: size.width * 0.03,
                                      ),
                                      labelStyle: GoogleFonts.roboto(
                                        color: Colors.black,
                                      ),
                                      labelText: 'Năm',
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
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    (snapshot.hasError &&
                            (snapshot.error as Map<String, String>)
                                .containsKey("time"))
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (snapshot.error as Map<String, String>)["time"]!,
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
                        'GPA (không bắt buộc)',
                        style: GoogleFonts.roboto(
                          color: ColorConstant.gray43,
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.02,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: size.height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.whiteF3,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        width: size.width * 0.3,
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
                            onChanged: (value) {
                              _educationBloc.eventController.sink.add(
                                  FillGPAEducationEvent(
                                      gpa: value.toString().trim()));
                            },
                            cursorColor: ColorConstant.primaryColor,
                            controller: gpaController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: size.width * 0.04,
                              ),
                              hintText: "GPA",
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
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Miêu tả (không bắt buộc)',
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
                      margin: EdgeInsets.only(
                        bottom: size.height * 0.01,
                      ),
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
                          maxLines: 11,
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          cursorColor: ColorConstant.primaryColor,
                          controller: descriptionController,
                          onChanged: (value) {
                            _educationBloc.eventController.sink.add(
                                FillDescriptionEducationEvent(
                                    description: value.toString().trim()));
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              top: size.width * 0.1,
                              left: size.width * 0.04,
                            ),
                            hintText: "...",
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
                        'Chứng chỉ đã tốt nghiệp',
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
                    (!isEducationImgCheck)
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
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.02),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _getEducationImageFromGallery();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.02),
                                image: DecorationImage(
                                    image: FileImage(imageFileEducationImg),
                                    fit: BoxFit.fill),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _getEducationImageFromGallery();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                .containsKey("educationImg"))
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (snapshot.error
                                  as Map<String, String>)["educationImg"]!,
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
                          _educationBloc.eventController.sink.add(
                              UpdateEducationEvent(
                                  educationID: educationID, context: context));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: ColorConstant.primaryColor),
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
      },
    );
  }
}
