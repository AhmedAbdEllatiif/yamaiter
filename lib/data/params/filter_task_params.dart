class FilterTasksParams {
  final String userToken;
  final String city;
  final String orderedBy;
  final int applicantsCount;
  int offset;

  FilterTasksParams({
    required this.userToken,
    required this.city,
    required this.orderedBy,
    required this.applicantsCount,
    required this.offset,
  });
}
