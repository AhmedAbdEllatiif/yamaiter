import 'dart:convert';

import '../../../../domain/entities/data/charge_balance_entity.dart';

ChargeBalanceResponseModel chargeBalanceModelFromJson(String str) {
  final myJson = json.decode(str);

  if (myJson == null) {
    throw Exception("ChargeBalanceResponseModel >> "
        "chargeBalanceModelFromJson >> myJson is null");
  }

  return ChargeBalanceResponseModel.fromJson(myJson);
}

class ChargeBalanceResponseModel extends ChargeBalanceEntity {
  final num billReferenceNum;

  ChargeBalanceResponseModel({required this.billReferenceNum})
      : super(
          billReference: billReferenceNum.toString(),
        );

  factory ChargeBalanceResponseModel.fromJson(dynamic json) {
    return ChargeBalanceResponseModel(
      billReferenceNum: json["bill_reference"] ?? -1,
    );
  }
}
