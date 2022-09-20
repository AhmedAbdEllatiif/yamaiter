import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/auto_login_entity.dart';

abstract class AppSettingsDataSource {
  /// return LoginStatus
  Future<AutoLoginEntity> getAutoLogin();

  /// return save LoginStatus
  Future<void> saveLoginStatus(AutoLoginEntity autoLoginEntity);

  /// to remove auto login
  Future<void> deleteAutoLogin();

  /*/// return UserEntity
  Future<UserEntity> getCurrentUser();

  /// save current user Entity
  Future<void> saveCurrentUser(UserEntity userEntity);

  /// to remove current user data
  Future<void> deleteCurrentUser();*/
}

class AppSettingsDataSourceImpl extends AppSettingsDataSource {
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

  /// to remove current user data
  @override
  Future<void> deleteCurrentUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList("currentUser", []);
  }

 /* /// return UserEntity
  @override
  Future<UserEntity> getCurrentUser() async {
    const defaultUserData =
        UserEntity(id: "", name: "Adzily User", email: "example@adzily.com");
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final currentUserData = preferences.getStringList("currentUser") ?? [];
    return currentUserData.isNotEmpty
        ? UserEntity(
            id: currentUserData[0],
            name: currentUserData[1],
            email: currentUserData[2],
          )
        : defaultUserData;
  }

  /// save current user Entity
  @override
  Future<void> saveCurrentUser(UserEntity userEntity) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList("currentUser", [
      userEntity.id,
      userEntity.name,
      userEntity.email,
    ]);
  }*/
}
