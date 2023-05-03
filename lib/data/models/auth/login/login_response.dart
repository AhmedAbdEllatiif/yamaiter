// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/data/models/authorized_user_model.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel extends LoginResponseEntity {
  LoginResponseModel({
    required this.success,
    required this.userToken,
    required this.user,
  }) : super(
          token: userToken,
          userEntity: user,
        );

  final String success;
  final AuthorizedUserModel user;
  final String userToken;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        success: json["success"] ?? AppUtils.undefined,
        user: AuthorizedUserModel.fromJson(json["user"]),
        userToken: json["token"] ?? AppUtils.undefined,
      );
}
