

import 'package:elssit/core/models/transaction_models/transaction_data_model.dart';

class TransactionModel {
  TransactionModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<TransactionDataModel> data;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: List<TransactionDataModel>.from(json["data"].map((x) => TransactionDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}