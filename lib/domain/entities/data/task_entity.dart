import 'package:equatable/equatable.dart';

import '../../../common/constants/app_utils.dart';
import '../../../data/api/constants.dart';
import '../../../data/models/user_lawyer_model.dart';

class TaskEntity extends Equatable {
  final int id;
  final String title;
  final String court;
  final String governorates;
  final String description;
  final int price;
  final String status;
  final String file;
  final int applicantsCount;

  /// dates in strings
  late final String startingDate;
  late final String createdAt;
  late final String updatedAt;

  /// creator
  late final String creatorName;
  late final String creatorPhoneNum;
  late final int creatorRating;
  late final String creatorImage;

  TaskEntity({
    required this.id,
    required this.title,
    required this.court,
    required this.governorates,
    required this.description,
    required this.price,
    required this.status,
    required this.file,
    required this.applicantsCount,
    required UserLawyerModel lawyerModel,
    required final DateTime? taskStartingDate,
    required final DateTime? taskCreatedAt,
    required final DateTime? taskUpdatedAt,
  }) {
    /// init startingDate
    if (taskStartingDate != null) {
      startingDate =
          "${taskStartingDate.year.toString()}-${taskStartingDate.month.toString().padLeft(2, '0')}-"
          "${taskStartingDate.day.toString().padLeft(2, '0')} ";
      //" ${taskStartingDate.hour.toString().padLeft(2, '0')}:"
      //"${taskStartingDate.minute.toString().padLeft(2, '0')}";
    } else {
      startingDate = AppUtils.undefined;
    }

    /// init takeCreatedAt
    if (taskCreatedAt != null) {
      createdAt =
          "${taskCreatedAt.year.toString()}-${taskCreatedAt.month.toString().padLeft(2, '0')}-"
          "${taskCreatedAt.day.toString().padLeft(2, '0')} ";
      //" ${taskCreatedAt.hour.toString().padLeft(2, '0')}:"
      //"${taskCreatedAt.minute.toString().padLeft(2, '0')}";
    } else {
      createdAt = AppUtils.undefined;
    }

    /// init takeUpdatedAt
    if (taskUpdatedAt != null) {
      updatedAt =
          "${taskUpdatedAt.year.toString()}-${taskUpdatedAt.month.toString().padLeft(2, '0')}-"
          "${taskUpdatedAt.day.toString().padLeft(2, '0')} ";
      //" ${taskUpdatedAt.hour.toString().padLeft(2, '0')}:"
      //"${taskUpdatedAt.minute.toString().padLeft(2, '0')}";
    } else {
      updatedAt = AppUtils.undefined;
    }

    /// init creator data
    creatorName = lawyerModel.name;
    creatorPhoneNum = lawyerModel.phoneNum;
    creatorRating = lawyerModel.rating;
    creatorImage = ApiConstants.mediaUrl + lawyerModel.profileImage;
  }

  @override
  List<Object?> get props => [id];
}
