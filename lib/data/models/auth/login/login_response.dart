// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/enum/user_type.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';
import 'package:yamaiter/domain/entities/data/user_entity.dart';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel extends LoginResponseEntity{
  LoginResponseModel({
    required this.success,
    required this.token,
    required this.tokenType,
    required this.user,
  }):super(
    token: token,
    userEntity: user,
  );

  final String success;
  final UserModel user;
  final String token;
  final String tokenType;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        success: json["success"] ?? AppUtils.undefined,
        user: UserModel.fromJson(json["user"]),
        token: json["token"] ?? AppUtils.undefined,
        tokenType: json["token_type"] ?? AppUtils.undefined,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "user": user.toJson(),
        "token": token,
        "token_type": tokenType,
      };
}

/// UserModel received from login response
/// TODO >> Change emailVerifiedAt type
class UserModel extends UserEntity {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.emailVerifiedAt,
    required this.userableType,
    required this.userableId,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
          id: id,
          name: name,
          email: email,
          phoneNum: phone.toString(),
          userType: userableType.contains("Lawyer")
              ? UserType.lawyer
              : userableType.contains("Client")
                  ? UserType.client
                  : UserType.unDefined,
          isVerified: emailVerifiedAt != AppUtils.undefined,
        );

  final int id;
  final String name;
  final String email;
  final int phone;
  final dynamic emailVerifiedAt;
  final String userableType;
  final int userableId;
  final String createdAt;
  final String updatedAt;



  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] - 1,
        name: json["name"] ?? AppUtils.undefined,
        email: json["email"] ?? AppUtils.undefined,
        phone: json["phone"] ?? AppUtils.undefined,
        emailVerifiedAt: json["email_verified_at"] ?? AppUtils.undefined,
        userableType: json["userable_type"] ?? AppUtils.undefined,
        userableId: json["userable_id"] ?? AppUtils.undefined,
        createdAt: json["created_at"] ?? AppUtils.undefined,
        updatedAt: json["updated_at"] ?? AppUtils.undefined,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "email_verified_at": emailVerifiedAt,
        "userable_type": userableType,
        "userable_id": userableId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  UserType buildUserType() {
    return userableType.contains("Lawyer")
        ? UserType.lawyer
        : userableType.contains("Client")
            ? UserType.client
            : UserType.unDefined;
  }
}
