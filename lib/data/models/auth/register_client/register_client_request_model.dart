class RegisterClientRequestModel {
  RegisterClientRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.governorates,
    required this.password,
    required this.acceptTerms,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String governorates;
  final String password;
  final bool acceptTerms;

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "email": email,
      "governorates": governorates,
      "password": password,
      "password_confirmation": password,
      "accept_terms": acceptTerms ? "yes": "no",
    };
  }
}
