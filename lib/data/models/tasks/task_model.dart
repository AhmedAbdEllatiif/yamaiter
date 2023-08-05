import 'dart:convert';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/enum/user_type.dart';

import '../../../domain/entities/data/task_entity.dart';
import '../user_lawyer_model.dart';

List<TaskModel> listOfTasksFromJson(String str) {
  final List<TaskModel> taskList = [];

  final feesJson = json.decode(str)["fees"];
  final tasksJson = json.decode(str)["tasks"];

  if (tasksJson == null) return taskList;

  tasksJson.forEach((taskJsonObject) {
    taskList.add(
      TaskModel.fromJson(
        taskJson: taskJsonObject,
        feesJson: feesJson ?? {},
      ),
    );
  });

  return taskList;
}

/// return a taskModel from json
TaskModel taskModelFromJson(String body) {
  return TaskModel.fromJson(
    taskJson: json.decode(body)["task"] ?? {},
    feesJson: json.decode(body)["fees"] ?? {},
  );
}

class TaskModel extends TaskEntity {
  TaskModel({
    required this.taskId,
    required this.taskTitle,
    required this.taskCourt,
    required this.taskGovernorates,
    required this.taskDescription,
    required this.taskPrice,
    required this.taskStatus,
    required this.taskFile,
    required this.costFees,
    required this.refundFees,
    required this.taskApplicantsCount,
    required this.taskStartingDate,
    required this.taskCreatedAt,
    required this.taskUpdatedAt,
    required this.taskCreatorType,
    required this.userLawyerModel,
    required this.taskAssignedLawyers,
    required this.taskApplicantLawyers,
    required this.taskRecommenderLawyers,
    required this.currentChatId,
    required this.currentChatChannel,
    required this.appliedForThisTask
  }) : super(
          id: taskId,
          title: taskTitle,
          court: taskCourt,
          governorates: taskGovernorates,
          description: taskDescription,
          price: taskPrice,
          status: taskStatus,
          alreadyApplied: appliedForThisTask,
          file: taskFile,
          costCommission: costFees,
          refundCommission: refundFees,
          lawyerModel: userLawyerModel[0],
          applicantsCount: taskApplicantsCount,
          assignedLawyers: taskAssignedLawyers,
          applicantLawyers: taskApplicantLawyers,
          recommenderLawyers: taskRecommenderLawyers,
          creatorType: taskCreatorType,
          taskStartingDate: taskStartingDate,
          taskCreatedAt: taskCreatedAt,
          taskUpdatedAt: taskUpdatedAt,
          chatId: currentChatId,
          chatChannel: currentChatChannel,
        );

  final int taskId;
  final String taskTitle;
  final String taskCourt;
  final String taskGovernorates;
  final String taskDescription;
  final int taskPrice;
  final String taskStatus;
  final String taskFile;
  final String costFees;
  final String refundFees;
  final int taskApplicantsCount;
  final DateTime? taskStartingDate;
  final DateTime? taskCreatedAt;
  final DateTime? taskUpdatedAt;
  final UserType taskCreatorType;
  final List<UserLawyerModel> userLawyerModel;
  final List<UserLawyerModel> taskAssignedLawyers;
  final List<UserLawyerModel> taskApplicantLawyers;
  final List<UserLawyerModel> taskRecommenderLawyers;

  final int currentChatId;
  final String currentChatChannel;
  final bool appliedForThisTask;

  factory TaskModel.fromJson(
      {required Map<String, dynamic> taskJson,
      required Map<String, dynamic> feesJson}) {
    // init chat json form user json
    Map<String, dynamic> chatJson = {};
    Map<String, dynamic> userJson = {};

    userJson = taskJson["user"] != null
        ? (taskJson["user"] as List).isNotEmpty
            ? taskJson["user"][0]
            : {}
        : {};

    chatJson = userJson["chat"] != null
        ? (userJson["chat"] as List).isNotEmpty
            ? userJson["chat"][0]
            : {}
        : {};

    return TaskModel(
      taskId: taskJson["id"] ?? -1,
      taskTitle: taskJson["title"] ?? AppUtils.undefined,
      taskCourt: taskJson["court"] ?? AppUtils.undefined,
      taskGovernorates: taskJson["governorates"] ?? AppUtils.undefined,
      taskDescription: taskJson["description"] ?? AppUtils.undefined,
      taskStatus: taskJson["status"] ?? AppUtils.undefined,
      taskFile: taskJson["task_file"] ?? AppUtils.undefined,
      taskPrice: taskJson["price"] ?? 0.0,
      taskApplicantsCount: taskJson["applicants_count"] ?? 0,

      // startingDate
      taskStartingDate: taskJson["starting_date"] != null
          ? DateTime.tryParse(taskJson["starting_date"])
          : null,

      // createdAt
      taskCreatedAt: taskJson["created_at"] != null
          ? DateTime.tryParse(taskJson["created_at"])
          : null,

      // updatedAt
      taskUpdatedAt: taskJson["updated_at"] != null
          ? DateTime.tryParse(taskJson["updated_at"])
          : null,

      // appliedForThisTask
      appliedForThisTask: taskJson["already_applied"] ?? false,

      // costFees
      costFees: feesJson["task_fees"] != null
          ? feesJson["task_fees"] ?? AppUtils.undefined
          : AppUtils.undefined,

      // refundFees
      refundFees: feesJson["refund_fees"] != null
          ? feesJson["refund_fees"] ?? AppUtils.undefined
          : AppUtils.undefined,

      taskCreatorType: taskJson["user"] != null
          ? taskJson["user"].isNotEmpty
              ? (taskJson["user"][0]["userable_type"] as String)
                      .contains("Client")
                  ? UserType.client
                  : UserType.lawyer
              : UserType.unDefined
          : UserType.unDefined,

      // lawyer owner
      userLawyerModel: taskJson["user"] != null
          ? List<UserLawyerModel>.from(
              taskJson["user"].map((x) => UserLawyerModel.fromJson(x)),
            )
          : [UserLawyerModel.empty()],

      currentChatId: chatJson["id"] ?? -1,

      currentChatChannel: chatJson["chat_channel"] ?? AppUtils.undefined,

      // assigned lawyers
      taskAssignedLawyers: taskJson["assignedlawyers"] != null
          ? List<UserLawyerModel>.from(
              taskJson["assignedlawyers"]
                  .map((x) => UserLawyerModel.fromJson(x)),
            )
          : [UserLawyerModel.empty()],

      // applicant lawyers
      taskApplicantLawyers: taskJson["applicantlawyers"] != null
          ? List<UserLawyerModel>.from(
              taskJson["applicantlawyers"]
                  .map((x) => UserLawyerModel.fromJson(x)),
            )
          : [UserLawyerModel.empty()],

      // recommender lawyers
      taskRecommenderLawyers: taskJson["recommenderlawyers"] != null
          ? List<UserLawyerModel>.from(
              taskJson["recommenderlawyers"]
                  .map((x) => UserLawyerModel.fromJson(x)),
            )
          : [UserLawyerModel.empty()],
    );
  }
}
