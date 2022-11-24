class InviteToTaskRequestModel {
  final String taskId;

  InviteToTaskRequestModel({required this.taskId});

  Map<String, dynamic> toJson() {
    return {
      "id": taskId,
    };
  }
}
