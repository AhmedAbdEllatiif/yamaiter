class GetMyTasksClientParams {
  final String userToken;
  final String status;
  final int offset;

  GetMyTasksClientParams({
    required this.userToken,
    required this.status,
    required this.offset,
  });
}
