class PayForTaskModel {
  final String missionType;
  final String name;
  final String value;
  final String description;
  final int userId;
  final int taskId;

  PayForTaskModel({
    required this.missionType,
    required this.name,
    required this.value,
    required this.description,
    required this.userId,
    required this.taskId,
  });

  Map<String, dynamic> toJson() {
    return {
      "mission_type": missionType,
      "name": name,
      "amount_cents": value,
      "description": description,
      "user_id": userId.toString(),
      "task_id": taskId.toString(),
    };
  }
}
