import 'dart:async';
import 'dart:convert';

import 'package:elssit/core/models/rating_model/rating_model.dart';
import 'package:elssit/process/event/rating_event.dart';
import 'package:elssit/process/state/rating_state.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../core/utils/globals.dart' as globals;

class RatingBloc {
  final eventController = StreamController<RatingEvent>();
  final stateController = StreamController<RatingState>();

  RatingBloc() {
    eventController.stream.listen((event) {
      if (event is OtherRatingEvent) {
        stateController.sink.add(OtherRatingState());
      }
      if (event is GetAllRatingEvent) {
        getAllRating();
      }
    });
  }

  Future<void> getAllRating() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/rating/mobile/get-rating-by-sitter/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetAllRatingState(
            ratingData: RatingModel.fromJson(json.decode(response.body)).data));
      } else {
        if (kDebugMode) {
          print('Unable to fetch rating from the REST API');
        }
      }
    } finally {}
  }
}
