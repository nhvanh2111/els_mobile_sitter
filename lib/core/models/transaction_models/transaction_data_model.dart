class TransactionDataModel {
  TransactionDataModel({
    required this.id,
    required this.type,
    required this.amount,
    this.content,
    required this.createTime,
  });

  String id;
  String type;
  String amount;
  dynamic content;
  String createTime;
  factory TransactionDataModel.fromJson(Map<String, dynamic> json) => TransactionDataModel(
      id: json["id"],
      type: json["type"],
      amount: json["amount"],
      content: json["content"],
      createTime: json["createDateTime"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "amount": amount,
    "content": content,
  };
}