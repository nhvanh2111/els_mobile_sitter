import 'package:elssit/presentation/timeline_tracking/bloc/timeline_tracking_bloc.dart';
import 'package:flutter/Material.dart';

abstract class NoteEvent {}

class OtherNoteEvent extends NoteEvent {}

class InitLoadNoteEvent extends NoteEvent {}

class SubmitNoteEvent extends NoteEvent {
  SubmitNoteEvent({required this.context, required this.timelineBloc});

  BuildContext context;
  TimelineBloc timelineBloc;
}

class AddImageEvent extends NoteEvent {
  AddImageEvent({required this.imgUrl});

  final String imgUrl;
}
