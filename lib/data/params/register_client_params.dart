class RegisterClientParams {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String governorates;
  final String password;
  final bool isTermsAccepted;

  RegisterClientParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.governorates,
    required this.password,
    required this.isTermsAccepted,
  });
}
