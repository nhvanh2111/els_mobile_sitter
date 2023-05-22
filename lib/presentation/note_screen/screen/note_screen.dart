import 'dart:io';

import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/presentation/note_screen/bloc/note_bloc.dart';
import 'package:elssit/presentation/note_screen/bloc/note_event.dart';
import 'package:elssit/presentation/note_screen/bloc/note_state.dart';
import 'package:elssit/presentation/note_screen/screen/widget/form_field_widget.dart';
import 'package:elssit/presentation/timeline_tracking/bloc/timeline_tracking_bloc.dart';
import 'package:elssit/presentation/timeline_tracking/bloc/timeline_tracking_event.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({super.key, required this.timlineBloc});

  TimelineBloc timlineBloc;

  @override
  State<NoteScreen> createState() => _NoteScreenState(timlineBloc: timlineBloc);
}

class _NoteScreenState extends State<NoteScreen> {
  _NoteScreenState({required this.timlineBloc});

  TimelineBloc timlineBloc;
  final noteBloc = NoteBloc();

  String noteImage = "";
  late File imageFileNote;
  XFile? pickedFileNote;
  UploadTask? uploadTaskNote;
  bool _isAddNotePic = false;

  _getNoteImageFromGallery() async {
    pickedFileNote = (await ImagePicker().pickImage(
      source: ImageSource.camera,
    ));
    if (pickedFileNote != null) {
      setState(() {
        imageFileNote = File(pickedFileNote!.path);
      });
    }
    _isAddNotePic = true;
    final path = 'els_sitter_images/${pickedFileNote!.name}';
    final file = File(pickedFileNote!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTaskNote = ref.putFile(file);

    final snapshot = await uploadTaskNote!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    noteImage = urlDownload;
    noteBloc.eventController.sink.add(AddImageEvent(imgUrl: noteImage));
  }

  @override
  void initState() {
    // TODO: implement initState
    noteBloc.timelineBloc = timlineBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: noteBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.data is OtherNoteState) {}
          if (snapshot.data is UpdateNoteState) {}
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: ColorConstant.primaryColor,
              // automaticallyImplyLeading: false,
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ghi chú",
                ),
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: size.height * 0.028,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      _getNoteImageFromGallery();
                    }, icon: Icon(Icons.camera_alt_outlined))
              ],
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, vertical: 10),
              width: size.width,
              height: size.height * 0.1,
              child: ElevatedButton(
                  onPressed: () {
                    noteBloc.eventController.add(SubmitNoteEvent(
                        context: context, timelineBloc: timlineBloc));
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
                  child: Text(
                    "Lưu Ghi Chú",
                    style: GoogleFonts.roboto(
                      letterSpacing: 1,
                      color: Colors.white,
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            body: SingleChildScrollView(
              child: Column(children: [

                (_isAddNotePic)
                    ? Column(
                      children: [
                        Text(
                          "Hình ảnh:",
                          style: GoogleFonts.roboto(),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.03,
                            ),
                            child: Container(
                              height: size.height * 0.12,
                              width: size.height * 0.12,
                              decoration: BoxDecoration(
                                color: ColorConstant.primaryColor.withOpacity(0.2),
                                image: DecorationImage(
                                  image: FileImage(imageFileNote),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                    : const SizedBox(),
                SizedBox(height: size.height*0.02,),
                Text(
                  "Ghi chú:",
                  style: GoogleFonts.roboto(),
                ),
                Container(
                    padding: EdgeInsets.only(top: size.height*0.01),
                    child: FormFieldWidget(
                      padding: size.width * 0.05,
                      errorText: noteBloc.errorMessage,
                      controllerEditting: noteBloc.textController,
                      setValueFunc: noteBloc.setStringNote,
                    )),
                Text('${noteBloc.note.length}/${noteBloc.maximum}')
              ]),
            ),
          );
        });
  }
}
