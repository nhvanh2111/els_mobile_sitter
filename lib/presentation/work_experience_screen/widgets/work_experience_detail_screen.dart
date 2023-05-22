import 'dart:io';
import 'package:elssit/core/models/work_experience_models/work_experience_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elssit/core/utils/color_constant.dart';

import 'package:elssit/process/bloc/work_experience_bloc.dart';
import 'package:elssit/process/event/work_experience_event.dart';
import 'package:elssit/process/state/work_experience_state.dart';

class WorkExperienceDetailScreen extends StatefulWidget {
  const WorkExperienceDetailScreen({Key? key, required this.workExperienceID})
      : super(key: key);
  final String workExperienceID;

  @override
  State<WorkExperienceDetailScreen> createState() =>
      _WorkExperienceDetailScreenState(workExperienceID: workExperienceID);
}

class _WorkExperienceDetailScreenState
    extends State<WorkExperienceDetailScreen> {
  _WorkExperienceDetailScreenState({required this.workExperienceID});
  final String workExperienceID;

  final _workExperienceBloc = WorkExperienceBloc();

  late var jobTitleController = TextEditingController();
  late var expTimeController = TextEditingController();
  late var descriptionController = TextEditingController();

  void initState() {
    // TODO: implement initState
    super.initState();
    _workExperienceBloc.eventController.sink
        .add(GetWorkExperienceDetailEvent(workExperienceID: workExperienceID));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return StreamBuilder<WorkExperienceState>(
        stream: _workExperienceBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is GetWorkExperienceDetailState) {
              WorkExperienceDetailModel workExperienceDetail =
                  (snapshot.data as GetWorkExperienceDetailState)
                      .workExperience;
              _workExperienceBloc.eventController.sink.add(
                  FillJobTitleWorkExperienceEvent(
                      jobTitle: workExperienceDetail.data.jobTitle));
              jobTitleController = TextEditingController(
                  text: workExperienceDetail.data.jobTitle);
              _workExperienceBloc.eventController.sink.add(
                  FillExpTimeWorkExperienceEvent(
                      expTime: workExperienceDetail.data.expTime));
              expTimeController = TextEditingController(
                  text: workExperienceDetail.data.expTime);
              _workExperienceBloc.eventController.sink.add(
                  FillDescriptionWorkExperienceEvent(
                      description: workExperienceDetail.data.description));
              descriptionController = TextEditingController(
                  text: workExperienceDetail.data.description);
              _workExperienceBloc.eventController.sink
                  .add(WorkExperienceOtherEvent());
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
                      _workExperienceBloc.eventController.sink.add(
                          DeleteWorkExperienceEvent(
                              workExperienceID: workExperienceID,
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
                  child: const Text("Kinh Nghiệm Làm Việc"),
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
                          'Tên công việc',
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
                            controller: jobTitleController,
                            onChanged: (value) {
                              _workExperienceBloc.eventController.sink.add(
                                  FillJobTitleWorkExperienceEvent(
                                      jobTitle: value.toString().trim()));
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: size.width * 0.04,
                              ),
                              hintText: "Tên công việc đã thực hiện",
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
                                  .containsKey("jobTitle"))
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                (snapshot.error
                                    as Map<String, String>)["jobTitle"]!,
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
                          'Thời gian',
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
                            controller: expTimeController,
                            onChanged: (value) {
                              _workExperienceBloc.eventController.sink.add(
                                  FillExpTimeWorkExperienceEvent(
                                      expTime: value.toString().trim()));
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: size.width * 0.04,
                              ),
                              hintText: "Đã làm công việc này trong bao lâu",
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
                                  .containsKey("expTime"))
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                (snapshot.error
                                    as Map<String, String>)["expTime"]!,
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
                          'Mô tả (không bắt buộc)',
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
                            maxLines: 11,
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            cursorColor: ColorConstant.primaryColor,
                            controller: descriptionController,
                            onChanged: (value) {
                              _workExperienceBloc.eventController.sink.add(
                                  FillDescriptionWorkExperienceEvent(
                                      description: value.toString().trim()));
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: size.width * 0.04,
                                top: size.height * 0.05,
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
                        height: size.height * 0.01,
                      ),
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
                            _workExperienceBloc.eventController.sink.add(
                                UpdateWorkExperienceEvent(
                                    workExperienceID: workExperienceID,
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
