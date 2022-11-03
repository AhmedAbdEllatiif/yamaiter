import 'dart:convert';
import 'package:yamaiter/common/constants/app_utils.dart';

import '../../../domain/entities/data/task_entity.dart';
import '../user_lawyer_model.dart';

List<TaskModel> listOfTasksFromJson(String str) {
  final List<TaskModel> taskList = [];

  if (json.decode(str)["tasks"] != null) {
    json.decode(str)["tasks"].forEach((v) {
      taskList.add(TaskModel.fromJson(v));
    });
  }
  return taskList;
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
    required this.taskApplicantsCount,
    required this.taskStartingDate,
    required this.taskCreatedAt,
    required this.taskUpdatedAt,
    required this.userLawyerModel,
  }) : super(
          id: taskId,
          title: taskTitle,
          court: taskCourt,
          governorates: taskGovernorates,
          description: taskDescription,
          price: taskPrice,
          status: taskStatus,
          file: taskFile,
          lawyerModel: userLawyerModel[0],
          applicantsCount: taskApplicantsCount,
          taskStartingDate: taskStartingDate,
          taskCreatedAt: taskCreatedAt,
          taskUpdatedAt: taskUpdatedAt,
        );

  final int taskId;
  final String taskTitle;
  final String taskCourt;
  final String taskGovernorates;
  final String taskDescription;
  final int taskPrice;
  final String taskStatus;
  final String taskFile;
  final int taskApplicantsCount;
  final DateTime? taskStartingDate;
  final DateTime? taskCreatedAt;
  final DateTime? taskUpdatedAt;
  final List<UserLawyerModel> userLawyerModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        taskId: json["id"] ?? -1,
        taskTitle: json["title"] ?? AppUtils.undefined,
        taskCourt: json["court"] ?? AppUtils.undefined,
        taskGovernorates: json["governorates"] ?? AppUtils.undefined,
        taskDescription: json["description"] ?? AppUtils.undefined,
        taskStatus: json["status"] ?? AppUtils.undefined,
        taskFile: json["task_file"] ?? AppUtils.undefined,
        taskPrice: json["price"] ?? 0.0,
        taskApplicantsCount: json["applicants_count"] ?? 0,

        // startingDate
        taskStartingDate: json["starting_date"] != null
            ? DateTime.tryParse(json["starting_date"])
            : null,

        // createdAt
        taskCreatedAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,

        // updatedAt
        taskUpdatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,

        userLawyerModel: json["user"] != null
            ? List<UserLawyerModel>.from(
                json["user"].map((x) => UserLawyerModel.fromJson(x)),
              )
            : [UserLawyerModel.empty()],
      );
}
