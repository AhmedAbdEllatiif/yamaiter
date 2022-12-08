class UpdateTaskClientParams {
  final int id;
  final String title;
  final String price;
  final String court;
  final String description;
  final String governorates;
  final String startingDate;
  final String userToken;

  UpdateTaskClientParams({
    required this.id,
    required this.userToken,
    required this.title,
    required this.price,
    required this.court,
    required this.description,
    required this.governorates,
    required this.startingDate,
  });
}
