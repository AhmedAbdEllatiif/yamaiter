import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';

import '../../../../../domain/entities/data/client/consultation_entity.dart';

/// return a consultation model form json
ConsultationModel consultationFromJson(String str) {
  ConsultationModel? model;

  if (json.decode(str)["Consultation"] != null) {
    model = ConsultationModel.fromJson(json.decode(str)["Consultation"]);
  }
  return model ?? ConsultationModel.empty();
}

/// return a list of consultations form MyConsultations json
List<ConsultationModel> listOfMyConsultationsFromJson(String str) {
  final List<ConsultationModel> consultationsList = [];

  if (json.decode(str)["my consultations"] != null) {
    json.decode(str)["my consultations"].forEach((v) {
      consultationsList.add(ConsultationModel.fromJson(v));
    });
  }
  return consultationsList;
}

/// Model class for Consultation
class ConsultationModel extends ConsultationEntity {
  final int consultationId;
  final String consultationType;
  final String consultationDescription;
  final num consultationPrice;
  final DateTime? consultationCreatedAt;
  final DateTime? consultationUpdatedAt;
  final List<ConsultationFile> consultationFiles;

  ConsultationModel({
    required this.consultationId,
    required this.consultationType,
    required this.consultationDescription,
    required this.consultationPrice,
    required this.consultationCreatedAt,
    required this.consultationUpdatedAt,
    required this.consultationFiles,
  }) : super(
          id: consultationId,
          type: consultationType,
          description: consultationDescription,
          price: consultationPrice,
          consultationCreatedAt: consultationCreatedAt,
          consultationUpdatedAt: consultationUpdatedAt,
          receivedFiles: consultationFiles,
        );

  factory ConsultationModel.empty() => ConsultationModel(
        consultationId: -1,
        consultationType: AppUtils.undefined,
        consultationDescription: AppUtils.undefined,
        consultationPrice: 0,
        consultationCreatedAt: null,
        consultationUpdatedAt: null,
        consultationFiles: const [],
      );

  factory ConsultationModel.fromJson(Map<String, dynamic> json) =>
      ConsultationModel(
        // id
        consultationId: json["id"] ?? -1,

        // type or tile
        consultationType: json["type"] ?? AppUtils.undefined,

        // description
        consultationDescription: json["description"] ?? AppUtils.undefined,

        // price
        consultationPrice: json["price"] ?? 0,

        // createdAt
        consultationCreatedAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,

        // updatedAt
        consultationUpdatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,

        // files
        consultationFiles: json["files"] != null
            ? List<ConsultationFile>.from(
                json["files"].map((x) => ConsultationFile.fromJson(x)))
            : [],
      );
}

/// Consultation file
class ConsultationFile {
  final int id;
  final int consultationId;
  final String fileName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ConsultationFile({
    required this.id,
    required this.consultationId,
    required this.fileName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConsultationFile.fromJson(Map<String, dynamic> json) =>
      ConsultationFile(
        // id
        id: json["id"] ?? -1,

        // consultation id
        consultationId: json["consultation_id"] ?? -1,

        // final name
        fileName: json["file"] ?? AppUtils.undefined,

        // createdAt
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,

        // updatedAt
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
      );
}
