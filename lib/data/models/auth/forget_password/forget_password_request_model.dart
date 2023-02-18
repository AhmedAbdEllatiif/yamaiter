import 'package:yamaiter/data/params/forget_password_params.dart';

class ForgetPasswordRequestModel {
  final String email;

  ForgetPasswordRequestModel({
    required this.email,
  });

  factory ForgetPasswordRequestModel.fromParams(
      {required ForgetPasswordParams params}) {
    return ForgetPasswordRequestModel(
      email: params.email,
    );
  }

  Map<String, String> toJson() {
    return {
      "email": email,
    };
  }
}
