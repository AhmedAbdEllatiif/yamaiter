// To parse this JSON data, do
//
//     final mySosResponseModel = mySosResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';

import '../user_lawyer_model.dart';

MySosResponseModel mySosResponseModelFromJson(String str) =>
    MySosResponseModel.fromJson(json.decode(str));

class MySosResponseModel {
  MySosResponseModel({
    required this.mySosList,
  });

  final List<SosModel> mySosList;

  factory MySosResponseModel.fromJson(Map<String, dynamic> json) =>
      MySosResponseModel(
        mySosList: List<SosModel>.from(
          json["Distress Data"].map((x) => SosModel.fromJson(x)),
        ),
      );
}

/// Sos model
class SosModel extends SosEntity {
  SosModel({
    required this.modelId,
    required this.modelType,
    required this.modelGovernorate,
    required this.modelDescription,
    required this.modelCreatedAt,
    required this.updatedAt,
    required this.userLawyerModel,
  }) : super(
            id: modelId,
            title: modelType,
            governorate: modelGovernorate,
            description: modelDescription,
            createdAt: modelCreatedAt,
            lawyerModel: userLawyerModel[0]);

  final int modelId;
  final String modelType;
  final String modelGovernorate;
  final String modelDescription;
  final DateTime? modelCreatedAt;
  final DateTime? updatedAt;
  final List<UserLawyerModel> userLawyerModel;

  factory SosModel.fromJson(Map<String, dynamic> json) => SosModel(
        modelId: json["id"] ?? -1,
        modelType: json["type"] ?? AppUtils.undefined,
        modelGovernorate: json["governorate"] ?? AppUtils.undefined,
        modelDescription: json["description"] ?? AppUtils.undefined,
        modelCreatedAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
        userLawyerModel: json["users"] != null
            ? List<UserLawyerModel>.from(
                json["users"].map((x) => UserLawyerModel.fromJson(x)),
              )
            : [UserLawyerModel.empty()],
      );
}
