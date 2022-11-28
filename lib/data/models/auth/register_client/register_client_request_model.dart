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
  final bool acceptTerms;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "governorates": governorates,
      "password": password,
      "password_confirmation": password,
      "accept_terms": acceptTerms.toString(),
    };
  }
}
