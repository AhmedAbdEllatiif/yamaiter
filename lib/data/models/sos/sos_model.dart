// To parse this JSON data, do
//
//     final mySosResponseModel = mySosResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';

import '../user_lawyer_model.dart';

SosResponseModel mySosResponseModelFromDistressDataJson(String str) =>
    SosResponseModel.fromJsonDistressData(json.decode(str));

SosResponseModel mySosResponseModelFromAllDistressDataCallsJson(String str) =>
    SosResponseModel.fromJsonAllDistressDataCalls(json.decode(str));

class SosResponseModel {
  SosResponseModel({
    required this.mySosList,
  });

  final List<SosModel> mySosList;

  factory SosResponseModel.fromJsonDistressData(Map<String, dynamic> json) =>
      SosResponseModel(
        mySosList: List<SosModel>.from(
          json["Distress Data"].map((x) => SosModel.fromJson(x)),
        ),
      );

  factory SosResponseModel.fromJsonAllDistressDataCalls(Map<String, dynamic> json) =>
      SosResponseModel(
        mySosList: List<SosModel>.from(
          json["All Distresses calls"].map((x) => SosModel.fromJson(x)),
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
