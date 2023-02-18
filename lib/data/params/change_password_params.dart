class ChangePasswordParams {
  final String userToken;
  final String oldPassword;
  final String newPassword;

  ChangePasswordParams({
    required this.userToken,
    required this.oldPassword,
    required this.newPassword,
  });
}
