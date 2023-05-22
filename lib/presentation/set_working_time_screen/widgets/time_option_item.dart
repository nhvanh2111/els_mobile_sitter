import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/core/utils/my_utils.dart';
import 'package:elssit/process/bloc/working_time_bloc.dart';
import 'package:elssit/process/event/working_time_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/working_time_model/slot_data_model.dart';

StatefulWidget timeOptionItem(
    BuildContext context,
    WorkingTimeBloc workingTimeBloc,
    List<SlotDataModel> listSlot,
    Map<String, List<String>> mapWeek,
    String chosenDateInWeek,
    bool isSetSlotForAll, List<String> listSlotForAll) {
  var size = MediaQuery.of(context).size;
  return StatefulBuilder(
    builder: (context, setState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.15,
            child: ListView.separated(
              padding: EdgeInsets.only(
                left: size.width * 0.03,
                top: size.height * 0.02,
              ),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                String curDate = (index == 6) ? "CN" : "T${index + 2}";
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      chosenDateInWeek = (index == 6) ? "CN" : "T${index + 2}";
                      workingTimeBloc.eventController.sink.add(
                          SetChosenDateInWeekTimeEvent(
                              chosenDateInWeek: chosenDateInWeek));
                    });
                  },
                  child: Container(
                    width: size.width * 0.2,
                    height: size.height * 0.15,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: (mapWeek
                              .containsKey(MyUtils().convertWeekDay(curDate)))
                          ? ColorConstant.primaryColor
                          : ColorConstant.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(size.height * 0.015),
                    ),
                    child: Text(
                      (index == 6) ? "CN" : "T${index + 2}",
                      style: GoogleFonts.roboto(
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.w400,
                        color: (mapWeek
                                .containsKey(MyUtils().convertWeekDay(curDate)))
                            ? Colors.white
                            : Colors.black54,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                width: size.width * 0.02,
              ),
              itemCount: 7,
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Bật/Tắt lịch làm việc cho $chosenDateInWeek',
                    style: GoogleFonts.roboto(
                      color: ColorConstant.gray43,
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.02,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                FlutterSwitch(
                  activeColor: ColorConstant.primaryColor,
                  width: 45.0,
                  height: 25.0,
                  toggleSize: 20.0,
                  value: (mapWeek
                      .containsKey(MyUtils().convertWeekDay(chosenDateInWeek))),
                  borderRadius: 30.0,
                  // padding: 8.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      workingTimeBloc.eventController.sink.add(
                          ChooseDateInWeekWorkingTimeEvent(
                              date:
                                  MyUtils().convertWeekDay(chosenDateInWeek)));
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Chọn thời gian cho tất cả các ngày',
                    style: GoogleFonts.roboto(
                      color: ColorConstant.gray43,
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.02,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                FlutterSwitch(
                  activeColor: ColorConstant.primaryColor,
                  width: 45.0,
                  height: 25.0,
                  toggleSize: 20.0,
                  value: isSetSlotForAll,
                  borderRadius: 30.0,
                  // padding: 8.0,
                  showOnOff: false,
                  onToggle: (val) {
                    setState(() {
                      workingTimeBloc.eventController.sink.add(SetSlotForAllEvent(isSetSlotForAll: val));
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          (mapWeek.containsKey(MyUtils().convertWeekDay(chosenDateInWeek)) && !isSetSlotForAll)
              ? GridView.count(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: (1 / .4),
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  children: List.generate(listSlot.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        workingTimeBloc.eventController.sink.add(
                            ChooseSlotForDateInWeekWorkingTimeEvent(
                                date:
                                    MyUtils().convertWeekDay(chosenDateInWeek),
                                slot: "${index + 1}"));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                          top: size.height * 0.01,
                          bottom: size.height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: (mapWeek[MyUtils()
                                      .convertWeekDay(chosenDateInWeek)]!
                                  .contains("${index + 1}"))
                              ? ColorConstant.primaryColor
                              : ColorConstant.primaryColor.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(size.height * 0.03),
                        ),
                        child: Text(
                          listSlot[index].slots.split(" ")[1],
                          style: GoogleFonts.roboto(
                            color: (mapWeek[MyUtils()
                                        .convertWeekDay(chosenDateInWeek)]!
                                    .contains("${index + 1}"))
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: size.height * 0.018,
                          ),
                        ),
                      ),
                    );
                  }),
                )
              : const SizedBox(),
          (isSetSlotForAll)
              ? GridView.count(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: (1 / .4),
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 8.0,
            children: List.generate(listSlot.length, (index) {
              return GestureDetector(
                onTap: () {
                  workingTimeBloc.eventController.sink.add(
                      ChooseSlotForAllEvent(
                          slot: "${index + 1}"));
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                    top: size.height * 0.01,
                    bottom: size.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: (listSlotForAll.contains("${index + 1}"))
                        ? ColorConstant.primaryColor
                        : ColorConstant.primaryColor.withOpacity(0.1),
                    borderRadius:
                    BorderRadius.circular(size.height * 0.03),
                  ),
                  child: Text(
                    listSlot[index].slots.split(" ")[1],
                    style: GoogleFonts.roboto(
                      color: (listSlotForAll.contains("${index + 1}"))
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.018,
                    ),
                  ),
                ),
              );
            }),
          )
              : const SizedBox(),
        ],
      );
    },
  );
}
