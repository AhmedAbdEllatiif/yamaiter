class UpdateClientParams {
  final String userToken;
  final String image;
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String governorate;

  UpdateClientParams({
    required this.userToken,
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.governorate,
  });
}
