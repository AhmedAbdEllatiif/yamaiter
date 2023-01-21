import 'dart:convert';
import 'dart:developer';
import 'package:yamaiter/common/constants/app_utils.dart';

import '../../../domain/entities/data/task_entity.dart';
import '../user_lawyer_model.dart';

List<TaskModel> listOfTasksFromJson(String str) {
  final List<TaskModel> taskList = [];

  final tasksJson = json.decode(str)["tasks"];

  if (tasksJson == null) return taskList;

  tasksJson.forEach((taskJsonObject) {
    taskList.add(
      TaskModel.fromJson(
        taskJson: taskJsonObject,
        feesJson: taskJsonObject["fees"] ?? {},
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
    required this.userLawyerModel,
    required this.taskAssignedLawyers,
    required this.taskApplicantLawyers,
    required this.taskRecommenderLawyers,
    required this.currentChatId,
    required this.currentChatChannel,
  }) : super(
          id: taskId,
          title: taskTitle,
          court: taskCourt,
          governorates: taskGovernorates,
          description: taskDescription,
          price: taskPrice,
          status: taskStatus,
          file: taskFile,
          costCommission: costFees,
          refundCommission: refundFees,
          lawyerModel: userLawyerModel[0],
          applicantsCount: taskApplicantsCount,
          assignedLawyers: taskAssignedLawyers,
          applicantLawyers: taskApplicantLawyers,
          recommenderLawyers: taskRecommenderLawyers,
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
  final List<UserLawyerModel> userLawyerModel;
  final List<UserLawyerModel> taskAssignedLawyers;
  final List<UserLawyerModel> taskApplicantLawyers;
  final List<UserLawyerModel> taskRecommenderLawyers;

  final int currentChatId;
  final String currentChatChannel;

  factory TaskModel.fromJson(
          {required Map<String, dynamic> taskJson,
          required Map<String, dynamic> feesJson}) =>
      TaskModel(
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

        // costFees
        costFees: feesJson["task_fees"] != null
            ? feesJson["task_fees"] ?? AppUtils.undefined
            : AppUtils.undefined,

        // refundFees
        refundFees: feesJson["refund_fees"] != null
            ? feesJson["refund_fees"] ?? AppUtils.undefined
            : AppUtils.undefined,

        // lawyer owner
        userLawyerModel: taskJson["user"] != null
            ? List<UserLawyerModel>.from(
                taskJson["user"].map((x) => UserLawyerModel.fromJson(x)),
              )
            : [UserLawyerModel.empty()],

        currentChatId: taskJson["user"] != null
            ? taskJson["user"][0]["chat"][0]["id"]
            : -1,

        currentChatChannel: taskJson["user"] != null
            ? taskJson["user"][0]["chat"][0]["chat_channel"]
            : AppUtils.undefined,

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
