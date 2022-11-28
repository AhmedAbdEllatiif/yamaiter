import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/enum/user_type.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';

import '../../../../domain/entities/data/register_response_entity.dart';
import '../../authorized_user_model.dart';

RegisterClientResponseModel registerClientResponseModelFromJson(String str) =>
    RegisterClientResponseModel.fromJson(json.decode(str));

class RegisterClientResponseModel extends RegisterResponseEntity {
  RegisterClientResponseModel({
    required this.success,
    required this.userToken,
    required this.tokenType,
    required this.user,
  }) : super(
          token: userToken,
          userEntity: user,
        );

  final String success;
  final AuthorizedUserModel user;
  final String userToken;
  final String tokenType;

  factory RegisterClientResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterClientResponseModel(
        success: json["success"] ?? AppUtils.undefined,
        user: AuthorizedUserModel.fromJson(json["user"]),
        userToken: json["token"] ?? AppUtils.undefined,
        tokenType: json["token_type"] ?? AppUtils.undefined,
      );
}
