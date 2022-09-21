class RegisterLawyerRequestParams {
  final String name;
  final String email;
  final String phone;
  final String governorates;
  final String courtName;
  final String password;
  final String idPhotoPath;

  RegisterLawyerRequestParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.governorates,
    required this.courtName,
    required this.password,
    required this.idPhotoPath,
  });
}
