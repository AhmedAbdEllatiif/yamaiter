import 'package:yamaiter/data/params/change_password_params.dart';

class ChangePasswordRequestModel {
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequestModel({
    required this.oldPassword,
    required this.newPassword,
  });

  factory ChangePasswordRequestModel.fromParams(
      {required ChangePasswordParams params}) {
    return ChangePasswordRequestModel(
      oldPassword: params.oldPassword,
      newPassword: params.newPassword,
    );
  }

  Map<String, String> toJson() {
    return {
      "old_password": oldPassword,
      "new_password": newPassword,
      "new_password_confirmation": newPassword
    };
  }
}
