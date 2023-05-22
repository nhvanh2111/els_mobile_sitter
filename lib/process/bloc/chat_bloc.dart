import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../core/utils/globals.dart' as globals;
import '../event/chat_event.dart';
import '../state/chat_state.dart';

class ChatBloc{
  final eventController = StreamController<ChatEvent>();
  final stateController = StreamController<ChatState>();
  ChatBloc(){
    eventController.stream.listen((event) {
      if(event is SendMsgChatEvent){
        notiMsg(event.otherID);
      }
    });
  }
  Future<void> notiMsg(String otherID) async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/common/mobile/notification-message/$otherID");

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, String>{},
        ),
      );
      print('test status code notiMsg: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {} else {}
    } finally {}
  }
}