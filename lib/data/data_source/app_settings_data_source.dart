import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamaiter/common/enum/accept_terms.dart';
import 'package:yamaiter/common/enum/user_type.dart';

import '../../domain/entities/auto_login_entity.dart';
import '../../domain/entities/data/authorized_user_entity.dart';

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
  Future<AuthorizedUserEntity> getCurrentUser();

  /// save current user Entity
  Future<void> saveCurrentUser(AuthorizedUserEntity userEntity);

  /// to remove current user data
  Future<void> deleteCurrentUser();

  //=======================>  Notifications Settings   <======================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  /// update notifications listener
  Future<void> updateNotificationsListener(String value);

  /// get notifications listener
  Future<Map<String, bool>> getNotificationsListener();


  //==========================>  First App launch <===========================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  /// return bool
  Future<bool> isAppFirstLaunch();

  /// return save LoginStatus
  Future<void> changeAppFirstLaunchStatus();
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
    preferences.setInt("userId", -1);
    preferences.setStringList("userData", []);
  }

  /// return UserEntity
  @override
  Future<AuthorizedUserEntity> getCurrentUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    // userId
    final userId = preferences.getInt("userId") ?? -1;

    // userData
    final data = preferences.getStringList("userData") ?? [];

    // return user data
    return data.isNotEmpty
        ? AuthorizedUserEntity(
            id: userId,
            firstName: data[0],
            lastName: data[1],
            email: data[2],
            userType: userTypeFromString(data[3]),
            phoneNum: data[4],
            profileImage: data[5],
            governorates: data[6],
            courtName: data[7],
            rating: double.tryParse(data[8]) ?? 0,
            acceptTerms: acceptTermsFromString(data[9]))
        : AuthorizedUserEntity.empty();
  }

  /// save current user Entity
  @override
  Future<void> saveCurrentUser(AuthorizedUserEntity userEntity) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("userId", userEntity.id);
    preferences.setStringList("userData", [
      userEntity.firstName,
      userEntity.lastName,
      userEntity.email,
      userEntity.userType.toShortString(),
      userEntity.phoneNum,
      userEntity.userAvatar,
      userEntity.governorates,
      userEntity.courtName,
      userEntity.rating.toString(),
      userEntity.acceptTerms.toShortString(),
    ]);
  }

  //=======================>  Notifications Settings   <======================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  /// update notifications listeners
  @override
  Future<void> updateNotificationsListener(String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("notificationsListener", value);
  }

  /// get notifications listeners
  @override
  Future<Map<String, bool>> getNotificationsListener() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final str = preferences.getString("notificationsListener") ?? "";

    /// return empty
    if (str.isEmpty) return <String, bool>{};

    final json = jsonDecode(str) as Map<String, dynamic>;

    /// build map to return
    final Map<String, bool> mapOfStrAndBool = {};
    json.forEach((key, value) {
      mapOfStrAndBool.addAll({key: value ?? false});
    });

    return mapOfStrAndBool;
  }


  //==========================>  First App launch <===========================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  @override
  Future<void> changeAppFirstLaunchStatus() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isFirstLaunch", false);
  }

  @override
  Future<bool> isAppFirstLaunch() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final firstLaunchStatus = preferences.getBool("isFirstLaunch") ?? true;
    return firstLaunchStatus;
  }
}
