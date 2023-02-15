// To parse this JSON data, do
//
//     final taxModel = taxModelFromJson(jsonString);

import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';

import '../../../domain/entities/tax_entity.dart';

List<TaxModel> listOfCompletedTaxesFromJson(String str) {
  final List<TaxModel> articleModels = [];

  if (json.decode(str)["taxes"] != null) {
    json.decode(str)["taxes"].forEach((v) {
      articleModels.add(TaxModel.fromJson(v));
    });
  }

  return articleModels.reversed.toList();
}

List<TaxModel> listOfInProgressTaxesFromJson(String str) {
  final List<TaxModel> articleModels = [];

  if (json.decode(str)["tax"] != null) {
    json.decode(str)["tax"].forEach((v) {
      articleModels.add(TaxModel.fromJson(v));
    });
  }

  return articleModels.reversed.toList();
}

TaxModel taxModelFromJson(String str) => TaxModel.fromJson(json.decode(str));

class TaxModel extends TaxEntity {
  TaxModel({
    required this.taxId,
    required this.taxStatus,
    required this.taxFile,
    required this.adminFile,
    required this.taxName,
    required this.taxPassword,
    required this.serviceCost,
    required this.notes,
    required this.createdDate,
    required this.updatedDate,
    required this.pivot,
  }) : super(
          id: taxId,
          name: taxName,
          adminFileName: adminFile,
          password: taxPassword,
          status: taxStatus,
          cost: serviceCost.toDouble(),
          createdDate: createdDate,
        );

  final int taxId;
  final String taxStatus;
  final String taxFile;
  final String taxName;
  final String taxPassword;
  final num serviceCost;
  final String notes;
  final String adminFile;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final Pivot pivot;

  factory TaxModel.fromJson(Map<String, dynamic> json) => TaxModel(
        taxId: json["id"] ?? -1,
        taxStatus: json["status"] ?? AppUtils.undefined,
        taxFile: json["tax_file"] ?? AppUtils.undefined,
        adminFile: json["feedback"] ?? AppUtils.undefined,
        taxName: json["tax_name"] ?? AppUtils.undefined,
        taxPassword: json["tax_password"] ?? AppUtils.undefined,
        serviceCost: json["service_cost"] ?? 0.0,
        notes: json["notes"] ?? AppUtils.undefined,
        createdDate: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        updatedDate: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
        pivot: json["pivot"] != null
            ? Pivot.fromJson(json["pivot"])
            : Pivot.empty(),
      );
}

class Pivot {
  Pivot({
    required this.lawyerId,
    required this.taxId,
  });

  final int lawyerId;
  final int taxId;

  factory Pivot.empty() => Pivot(
        lawyerId: -1,
        taxId: -1,
      );

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        lawyerId: json["lawyer_id"] ?? -1,
        taxId: json["tax_id"] ?? -1,
      );
}
