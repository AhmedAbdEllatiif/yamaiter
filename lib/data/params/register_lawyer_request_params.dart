class RegisterLawyerRequestParams {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String governorates;
  final String courtName;
  final String password;
  final String idPhotoPath;

  RegisterLawyerRequestParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.governorates,
    required this.courtName,
    required this.password,
    required this.idPhotoPath,
  });
}
