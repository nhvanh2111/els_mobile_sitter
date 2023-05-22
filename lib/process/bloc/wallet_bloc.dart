import 'dart:async';
import 'dart:convert';
import '../../core/utils/globals.dart' as globals;
import '../event/wallet_event.dart';
import '../state/wallet_state.dart';
import 'package:http/http.dart' as http;

class WalletBloc{
  final eventController = StreamController<WalletEvent>();
  final stateController = StreamController<WalletState>();
  WalletBloc(){
    eventController.stream.listen((event) {
      if(event is GetBalanceWalletEvent){
        getWalletBalance();
      }
    });
  }

  Future<void> getWalletBalance() async {
    try {
      var url = Uri.parse(
          "https://monkfish-app-ocxq6.ondigitalocean.app/api/v1/payment/common/get-wallet/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(GetBalanceWalletState(balance: json.decode(response.body)["data"]["amount"].toString()));
      } else {
        throw Exception('Unable to fetch balance from the REST API');
      }
    } finally {}
  }



}