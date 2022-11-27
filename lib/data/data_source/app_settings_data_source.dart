import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamaiter/common/enum/user_type.dart';

import '../../domain/entities/auto_login_entity.dart';
import '../../domain/entities/data/user_entity.dart';

abstract class AppSettingsDataSource {
  //===============================>  Token  <================================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  /// return LoginStatus
  Future<AutoLoginEntity> getAutoLogin();

  /// return save LoginStatus
  Future<void> saveLoginStatus(AutoLoginEntity autoLoginEntity);

  /// to remove auto login
  Future<void> deleteAutoLogin();

  //=============================>  User Date   <=============================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  /// return UserEntity
  Future<UserEntity> getCurrentUser();

  /// save current user Entity
  Future<void> saveCurrentUser(UserEntity userEntity);

  /// to remove current user data
  Future<void> deleteCurrentUser();
}

class AppSettingsDataSourceImpl extends AppSettingsDataSource {
  //===============================>  Token  <================================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  /// return LoginStatus
  @override
  Future<AutoLoginEntity> getAutoLogin() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final currentUserToken = preferences.getString("isLoggedIn") ?? "";
    return AutoLoginEntity(userToken: currentUserToken);
  }

  /// return save LoginStatus
  @override
  Future<void> saveLoginStatus(AutoLoginEntity autoLoginEntity) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("isLoggedIn", autoLoginEntity.userToken);
  }

  /// to remove auto login
  @override
  Future<void> deleteAutoLogin() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("isLoggedIn", "");
  }

  //=============================>  User Date   <=============================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  /// to remove current user data
  @override
  Future<void> deleteCurrentUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList("userData", []);
  }

  /// return UserEntity
  @override
  Future<UserEntity> getCurrentUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final userId = preferences.getInt("userId") ?? -1;
    final isVerified = preferences.getBool("isVerified") ?? false;

    final data = preferences.getStringList("userData") ?? [];
    return data.isNotEmpty
        ? UserEntity(
            id: userId,
            name: data[0],
            email: data[1],
            userType: userTypeFromString(data[2]),
            phoneNum: data[3],
            isVerified: isVerified)
        : UserEntity.empty();
  }

  /// save current user Entity
  @override
  Future<void> saveCurrentUser(UserEntity userEntity) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("userId", userEntity.id);
    preferences.setBool("isVerified", userEntity.isVerified);
    preferences.setStringList("userData", [
      userEntity.name,
      userEntity.email,
      userEntity.userType.toShortString(),
      userEntity.phoneNum,
    ]);
  }
}
