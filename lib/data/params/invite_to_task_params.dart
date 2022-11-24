class InviteToTaskParams {
  final String userToken;
  final int lawyerId;
  final int taskId;

  InviteToTaskParams({
    required this.userToken,
    required this.lawyerId,
    required this.taskId,
  });
}
