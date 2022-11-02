class GetMyTasksParams {
  final String userToken;
  final String status;
  final int offset;

  GetMyTasksParams({
    required this.userToken,
    required this.status,
    required this.offset,
  });
}
