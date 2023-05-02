import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/constants/app_utils.dart';

import '../../../../data/api/api_constants.dart';
import '../../../../data/models/consultations/consultation_model.dart';

class ConsultationEntity extends Equatable {
  final int id;
  final String type;
  final String description;
  final num price;
  final String feedBack;
  late final String createdAt;
  late final String updatedAt;
  late final List<String> files;

  ConsultationEntity({
    required this.id,
    required this.type,
    required this.description,
    required this.price,
    required this.feedBack,
    required DateTime? consultationCreatedAt,
    required DateTime? consultationUpdatedAt,
    required List<ConsultationFile> receivedFiles,
  }) {
    //==> init files
    files = [];
    if (receivedFiles.isNotEmpty) {
      for (var element in receivedFiles) {
        files.add(ApiConstants.mediaUrl + element.fileName);
      }
    }

    //==> init createdAt
    if (consultationCreatedAt != null) {
      createdAt =
          "${consultationCreatedAt.year.toString()}-${consultationCreatedAt.month.toString().padLeft(2, '0')}-"
          "${consultationCreatedAt.day.toString().padLeft(2, '0')} ";
      //" ${consultationCreatedAt.hour.toString().padLeft(2, '0')}:"
      //"${consultationCreatedAt.minute.toString().padLeft(2, '0')}";
    } else {
      createdAt = AppUtils.undefined;
    }

    //==> init updatedAt
    if (consultationUpdatedAt != null) {
      updatedAt =
          "${consultationUpdatedAt.year.toString()}-${consultationUpdatedAt.month.toString().padLeft(2, '0')}-"
          "${consultationUpdatedAt.day.toString().padLeft(2, '0')} ";
      //" ${consultationUpdatedAt.hour.toString().padLeft(2, '0')}:"
      //"${consultationUpdatedAt.minute.toString().padLeft(2, '0')}";
    } else {
      updatedAt = AppUtils.undefined;
    }
  }

  @override
  List<Object?> get props => [id];
}
