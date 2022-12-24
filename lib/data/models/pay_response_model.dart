import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/domain/entities/data/pay_entity.dart';



///  return PayResponseModel
PayResponseModel payResponseFromJson(String body) =>
    PayResponseModel.fromJson(json.decode(body));

class PayResponseModel extends PayEntity {
  final String payLink;

  const PayResponseModel({required this.payLink}) : super(link: payLink);

  factory PayResponseModel.fromJson(Map<String, dynamic> json) =>
      PayResponseModel(payLink: json["link"] ?? AppUtils.undefined);
}
