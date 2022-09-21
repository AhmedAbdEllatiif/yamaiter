class LoginRequestModel {
  final String email;
  final String password;
  final String rememberMe;

  LoginRequestModel({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  Map<String, dynamic> toJson() => {
        "credentials": email,
        "password": password,
        "remember_me": rememberMe,
      };
}
