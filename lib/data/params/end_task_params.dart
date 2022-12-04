class EndTaskParams {
  final String userToken;
  final double rating;
  final int taskId;

  EndTaskParams({
    required this.userToken,
    required this.rating,
    required this.taskId,
  });
}
