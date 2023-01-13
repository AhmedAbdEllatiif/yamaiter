import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/enum/payment_mission_type.dart';
import 'package:yamaiter/domain/entities/data/pay_entity.dart';

///  return PayResponseModel
PayResponseModel payResponseFromJson(String body) =>
    PayResponseModel.fromJson(json.decode(body));

class PayResponseModel extends PayEntity {
  final String payLink;
  final String missionTypeModel;
  final int missionIdModel;

  PayResponseModel({
    required this.payLink,
    required this.missionTypeModel,
    required this.missionIdModel,
  }) : super(
            link: payLink,
            missionId: missionIdModel,
            paymentMissionType:
                // tax
                missionTypeModel == PaymentMissionType.tax.toShortString()
                    ? PaymentMissionType.tax
                    // consultation
                    : missionTypeModel ==
                            PaymentMissionType.consultation.toShortString()
                        ? PaymentMissionType.consultation
                        // task
                        : missionTypeModel ==
                                PaymentMissionType.task.toShortString()
                            ? PaymentMissionType.task
                            // undefined
                            : PaymentMissionType.undefined);

  factory PayResponseModel.fromJson(Map<String, dynamic> json) =>
      PayResponseModel(
        //payLink
        payLink: json["link"] ?? AppUtils.undefined,

        //missionTypeModel
        missionTypeModel: json["data"] != null
            ? json["data"]["mission_type"] ?? AppUtils.undefined
            : AppUtils.undefined,

        // missionIdModel
        missionIdModel: json["data"] != null
            ? json["data"]["mission_id"] ?? -1
            : -1,
      );
}
/*
        "mission_type": "consultation",
        "name": "consultaion title new",
        "amount": "250",
        "description": "consultaion description new",
        "to_user_id": null,
        "mission_id": 4,
        "tax_password": null,
        "tax_file": "1672077450_first1.jpg"
        */
