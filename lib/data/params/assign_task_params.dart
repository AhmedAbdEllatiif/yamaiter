class AssignTaskParams {
  final String userToken;
  final int userId;
  final int taskId;

  AssignTaskParams({
    required this.userToken,
    required this.userId,
    required this.taskId,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId.toString(),
      "task_id": taskId.toString(),
    };
  }
}
