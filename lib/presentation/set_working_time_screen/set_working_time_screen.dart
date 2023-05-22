import 'dart:collection';

import 'package:elssit/core/utils/my_enum.dart';
import 'package:elssit/presentation/set_working_time_screen/widgets/time_option_item.dart';
import 'package:elssit/process/bloc/working_time_bloc.dart';
import 'package:elssit/process/event/working_time_event.dart';
import 'package:elssit/process/state/working_time_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/globals.dart' as globals;
import '../../core/models/working_time_model/slot_data_model.dart';
import '../../core/utils/color_constant.dart';

class SetWorkingTimeScreen extends StatefulWidget {
  const SetWorkingTimeScreen({Key? key}) : super(key: key);

  @override
  State<SetWorkingTimeScreen> createState() => _SetWorkingTimeScreenState();
}

class _SetWorkingTimeScreenState extends State<SetWorkingTimeScreen> {
  WorkingTimeType _workingTimeType = WorkingTimeType.date;
  final workingTimeBloc = WorkingTimeBloc();
  List<SlotDataModel> listSlot = globals.listSlot;

  Map<String, List<String>> mapWeek = HashMap();

  String chosenDateInWeek = "T2";
  bool isSetSlotForAll = false;
  List<String> listSlotForAll = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    workingTimeBloc.eventController.sink
        .add(SetChosenDateInWeekTimeEvent(chosenDateInWeek: chosenDateInWeek));
    workingTimeBloc.eventController.sink.add(GetAllWorkingTimeEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: workingTimeBloc.stateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          if (snapshot.data is ChooseDateInWeekWorkingTimeState) {
            mapWeek =
                (snapshot.data as ChooseDateInWeekWorkingTimeState).mapWeek;
          }
          if (snapshot.data is SetChosenDateInWeekTimeState) {
            chosenDateInWeek = (snapshot.data as SetChosenDateInWeekTimeState)
                .chosenDateInWeek;
          }
          if (snapshot.data is GetAllWorkingTimeState) {
            mapWeek = (snapshot.data as GetAllWorkingTimeState).mapWeek;
            workingTimeBloc.eventController.sink.add(OtherWorkingTimeEvent());
          }
          if (snapshot.data is SetSlotForAllState) {
            isSetSlotForAll =
                (snapshot.data as SetSlotForAllState).isSetSlotForAll;
          }
          if (snapshot.data is ChooseSlotForAllState) {
            listSlotForAll =
                (snapshot.data as ChooseSlotForAllState).listSlotForAll;
          }
        }
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
                "Thời gian làm việc",
              ),
            ),
            titleTextStyle: GoogleFonts.roboto(
              fontSize: size.height * 0.028,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            color: Colors.white,
            width: size.width,
            height: size.height * 0.12,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    workingTimeBloc.eventController.sink
                        .add(ConfirmWorkingTimeEvent(context: context));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.03),
                    ),
                    textStyle: TextStyle(
                      fontSize: size.width * 0.045,
                    ),
                  ),
                  child: (globals.sitterStatus == "CREATED" || globals.sitterStatus == "REJECTED") ? const Text("Tiếp theo") : const Text("Xác nhận"),
                ),
              ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    timeOptionItem(
                      context,
                      workingTimeBloc,
                      listSlot,
                      mapWeek,
                      chosenDateInWeek,
                      isSetSlotForAll,
                      listSlotForAll,
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
