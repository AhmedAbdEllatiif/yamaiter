class GetAppliedTasksParams {
  final String userToken;
  final String status;
  final int offset;

  GetAppliedTasksParams({
    required this.userToken,
    required this.status,
    required this.offset,
  });
}
