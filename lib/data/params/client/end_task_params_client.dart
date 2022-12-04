class EndTaskParamsClient {
  final String userToken;
  final double rating;
  final int taskId;

  EndTaskParamsClient({
    required this.userToken,
    required this.rating,
    required this.taskId,
  });
}
