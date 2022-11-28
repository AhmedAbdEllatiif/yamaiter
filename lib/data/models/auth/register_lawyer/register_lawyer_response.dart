import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/data/models/authorized_user_model.dart';

import '../../../../domain/entities/data/register_response_entity.dart';

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel extends RegisterResponseEntity {
  RegisterResponseModel({
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

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        success: json["success"] ?? AppUtils.undefined,
        user: AuthorizedUserModel.fromJson(json["user"]),
        userToken: json["token"] ?? AppUtils.undefined,
      );
}
