class ApplyForTaskParams {
  final String userToken;
  final int cost;
  final int taskId;

  ApplyForTaskParams({
    required this.userToken,
    required this.cost,
    required this.taskId,
  });

  Map<String, dynamic> toJson() {
    return {
      "cost": cost.toString(),
    };
  }
}
