class UpdateLawyerRequestModel {
  final String image;
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String governorate;
  final String court;
  final String aboutUser;

  UpdateLawyerRequestModel({
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.governorate,
    required this.court,
    required this.aboutUser,
  });
}
