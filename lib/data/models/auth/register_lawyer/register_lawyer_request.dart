import 'dart:io';

class RegisterRequestModel{
  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.governorates,
    required this.courtName,
    required this.password,
    required this.acceptTerms,
    required this.idPhoto,
  });

  final String name;
  final String email;
  final String phone;
  final String governorates;
  final String courtName;
  final String password;
  final String acceptTerms;
  final File idPhoto;
}
