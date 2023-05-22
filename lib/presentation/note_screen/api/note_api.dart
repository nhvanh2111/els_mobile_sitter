import 'dart:convert';

import 'package:elssit/presentation/timeline_tracking/model/timeline_model.dart';
import 'package:http/http.dart' as http;
import '../../../core/utils/globals.dart' as globals;

class NoteApi {
  static Future<void> saveNote(String note, String bookingDetailId, String imgUrl) async {
//
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/tracking/mobile/add-tracking");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "bookingDetailId": bookingDetailId,
            "image": imgUrl,
            "note": note
          },
        ),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode.toString() == '200') {
      
      } else {
        // ignore: avoid_print
      }
    } finally {}
  }
}
