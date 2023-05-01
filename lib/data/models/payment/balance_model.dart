import 'dart:convert';

import 'package:yamaiter/domain/entities/data/balance_entity.dart';

BalanceModel balanceModelFromJson(String str) {
  final myJson = json.decode(str);

  if (myJson == null) {
    throw Exception("BalanceModel >> balanceModelFromJson >> myJson is null");
  }

  return BalanceModel.fromJson(myJson);
}

class BalanceModel extends BalanceEntity {
  final num balanceAmount;

  BalanceModel({required this.balanceAmount})
      : super(
          currentBalance: balanceAmount.toDouble(),
        );

  factory BalanceModel.fromJson(dynamic json) {
    return BalanceModel(
      balanceAmount: json["current balance"] ?? -1,
    );
  }
}
