import 'dart:developer';

import 'package:equatable/equatable.dart';

import '../../../common/constants/app_utils.dart';
import '../../../data/api/api_constants.dart';
import '../../../data/models/user_lawyer_model.dart';

class TaskEntity extends Equatable {
  final int id;
  final String title;
  final String court;
  final String governorates;
  final String description;
  final int price;
  final String status;
  final int applicantsCount;
  final int chatId;
  final String chatChannel;
  late final String taskFileUrl;
  late final String fileName;

  //final List<UserLawyerModel> assignedLawyers;
  final List<UserLawyerModel> applicantLawyers;
  final List<UserLawyerModel> recommenderLawyers;

  /// commissions
  final String costCommission;
  final String refundCommission;

  /// dates in strings
  late final String startingDate;
  late final String createdAt;
  late final String updatedAt;

  /// creator
  late final String creatorName;
  late final String creatorPhoneNum;
  late final num creatorRating;
  late final String creatorImage;

  /// recommender lawyer
  late final UserLawyerModel recommenderLawyer;
  late final UserLawyerModel assignedLawyer;

  factory TaskEntity.empty() {
    return TaskEntity(
      id: -1,
      title: "title",
      court: "court",
      governorates: "governorates",
      description: "description",
      price: 100,
      status: "status",
      file: "file",
      chatId: -1,
      chatChannel: "chatChannel not found",
      costCommission: AppUtils.undefined,
      refundCommission: AppUtils.undefined,
      applicantsCount: 10,
      assignedLawyers: const [],
      applicantLawyers: const [],
      recommenderLawyers: const [],
      lawyerModel: UserLawyerModel.empty(),
      taskStartingDate: DateTime.now(),
      taskCreatedAt: DateTime.now(),
      taskUpdatedAt: DateTime.now(),
    );
  }

  TaskEntity({
    required this.id,
    required this.title,
    required this.court,
    required this.governorates,
    required this.description,
    required this.price,
    required this.status,
    required final String file,
    required this.costCommission,
    required this.refundCommission,
    required this.applicantsCount,
    //required this.assignedLawyers,
    required this.applicantLawyers,
    required this.recommenderLawyers,
    required this.chatId,
    required this.chatChannel,
    required List<UserLawyerModel> assignedLawyers,
    required UserLawyerModel lawyerModel,
    required final DateTime? taskStartingDate,
    required final DateTime? taskCreatedAt,
    required final DateTime? taskUpdatedAt,
  }) {
    /// init fileName
    if (file != AppUtils.undefined) {
      fileName = file;
    } else {
      fileName = AppUtils.undefined;
    }

    /// init fileUrl
    taskFileUrl = ApiConstants.mediaUrl + file;

    log("Fees >> costCommission: $costCommission , refundCommission: $refundCommission");

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
    creatorName = lawyerModel.lawyerFirstName;
    creatorPhoneNum = lawyerModel.lawyerPhoneNum;
    creatorRating = lawyerModel.lawyerRating;
    creatorImage = ApiConstants.mediaUrl + lawyerModel.lawyerProfileImage;

    /// init recommender lawyer
    if (recommenderLawyers.isNotEmpty) {
      recommenderLawyer = recommenderLawyers[0];
    } else {
      recommenderLawyer = UserLawyerModel.empty();
    }

    /// init assigned lawyer
    if (assignedLawyers.isNotEmpty) {
      assignedLawyer = assignedLawyers[0];
    } else {
      assignedLawyer = UserLawyerModel.empty();
    }
  }

  @override
  List<Object?> get props => [id];
}
