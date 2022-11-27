class RegisterClientRequestModel {
  RegisterClientRequestModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.governorates,
    required this.password,
    required this.acceptTerms,
  });

  final String name;
  final String email;
  final String phone;
  final String governorates;
  final String password;
  final String acceptTerms;
}
