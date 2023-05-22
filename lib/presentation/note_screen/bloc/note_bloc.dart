import 'dart:async';

import 'package:elssit/presentation/note_screen/api/note_api.dart';
import 'package:elssit/presentation/note_screen/bloc/note_event.dart';
import 'package:elssit/presentation/note_screen/bloc/note_state.dart';
import 'package:elssit/presentation/timeline_tracking/bloc/timeline_tracking_bloc.dart';
import 'package:elssit/presentation/timeline_tracking/bloc/timeline_tracking_event.dart';
import 'package:elssit/presentation/widget/dialog/fail_dialog.dart';
import 'package:flutter/Material.dart';

class NoteBloc {
  final eventController = StreamController<NoteEvent>();
  final stateController = StreamController<NoteState>();
  String errorMessage = "";
  late TimelineBloc timelineBloc;
  String note = "";
  int maximum = 150;
  TextEditingController textController = TextEditingController();
  String imgUrl = "";

  NoteBloc() {
    eventController.stream.listen((event) async {
      if (event is OtherNoteEvent) {
        stateController.sink.add(OtherNoteState());
      }
      if(event is AddImageEvent){
        imgUrl = event.imgUrl;
      }
      if (event is SubmitNoteEvent) {
        try {
          await NoteApi.saveNote(
              note, timelineBloc.listTimeLine.first.bookingDetailId, imgUrl);
          event.timelineBloc.eventController.sink
              .add(FetchTimelineEvent(context: event.context));
          Navigator.pop(event.context);
        } catch (e) {
          Navigator.pop(event.context);
          await showFailDialog(
              event.context,
              e.toString().contains(":")
                  ? e.toString().split(":")[1]
                  : e.toString());
        }
        stateController.sink.add(OtherNoteState());
      }
//
      //
    });
  }

  setStringNote(String value) {
    if (value.length <= maximum) {
      note = value;
      errorMessage = "";
    } else {
      textController.text = note;
      errorMessage = "Tối đa ${maximum} kí tự";
    }
    stateController.sink.add(OtherNoteState());
  }
}
