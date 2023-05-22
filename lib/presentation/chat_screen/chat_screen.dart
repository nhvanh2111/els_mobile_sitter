import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/core/utils/image_constant.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkjs_flutter/talkjs_flutter.dart';
import '../../core/utils/globals.dart' as globals;
import '../../process/bloc/chat_bloc.dart';
import '../../process/event/chat_event.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  ChatScreen(
      {Key? key,
      required this.otherID,
      required this.otherName,
      required this.otherEmail,
      required this.otherAvaUrl})
      : super(key: key);
  String otherID;
  String otherName;
  String otherEmail;
  String otherAvaUrl;

  @override
  // ignore: no_logic_in_create_state
  State<ChatScreen> createState() => _ChatScreenState(
      otherID: otherID,
      otherName: otherName,
      otherEmail: otherEmail,
      otherAvaUrl: otherAvaUrl);
}

class _ChatScreenState extends State<ChatScreen> {
  _ChatScreenState(
      {required this.otherID,
      required this.otherName,
      required this.otherEmail,
      required this.otherAvaUrl});

  String otherID;
  String otherName;
  String otherEmail;
  String otherAvaUrl;
  final chatBloc = ChatBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(otherAvaUrl.isEmpty){
      otherAvaUrl = ImageConstant.defaultAva;
    }
  }
  @override
  Widget build(BuildContext context) {
    final session = Session(
      appId: 'tYnvNipa',
      enablePushNotifications: true,
    );
    final me = session.getUser(
      id: globals.sitterID,
      name: globals.identifyInformation!.fullName,
      email: [globals.email],
      photoUrl: globals.identifyInformation!.avatarImg,
      // welcomeMessage: '',
      role: 'default',
    );
    session.me = me;
    final other = session.getUser(
      id: otherID,
      name: otherName,
      email: [otherEmail],
      photoUrl: otherAvaUrl,
      // welcomeMessage: 'Hey there! How are you? :-)',
      role: 'default',
    );

    final conversation = session.getConversation(
      id: Talk.oneOnOneId(me.id, other.id),
      participants: {Participant(me), Participant(other)},
    );
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: chatBloc.stateController.stream,
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Els Chat Demo',
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: ColorConstant.primaryColor,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: size.height * 0.03,
                  ),
                ),
                title: Text(
                  'Cuộc Trò Chuyện',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: size.height * 0.026,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Stack(
                children: [
                  ChatBox(
                    session: session,
                    conversation: conversation,
                    showChatHeader: false,
                    onSendMessage: (event) {
                      chatBloc.eventController.sink
                          .add(SendMsgChatEvent(otherID: otherID));
                    },
                  ),
                  Container(
                    width: size.width,
                    height: size.height * 0.08,
                    color: Colors.white,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.14,
                      margin: EdgeInsets.only(
                        top: size.height * 0.01,
                        left: size.width * 0.02,
                        right: size.width * 0.02,
                        //bottom: size.height * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(size.height * 0.015),
                        border: Border.all(
                          color: ColorConstant.whiteE3,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: size.height * 0.1,
                            height: size.height * 0.1,
                            margin: EdgeInsets.only(
                                top: size.height * 0.01,
                                bottom: size.height * 0.01),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorConstant.whiteE3,
                                width: 1,
                              ),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(otherAvaUrl),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            otherName,
                            style: GoogleFonts.roboto(
                              fontSize: size.height * 0.022,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          // SizedBox(
                          //   width: size.width * 0.03,
                          // ),
                          const Spacer(),
                          // Icon(
                          //   Icons.phone,
                          //   color: ColorConstant.primaryColor,
                          //   size: size.height * 0.03,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(right: size.width * 0.02),
                          // ),
                          Icon(
                            Icons.more_vert_outlined,
                            color: ColorConstant.primaryColor,
                            size: size.height * 0.035,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: size.width * 0.03),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
