import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';

import '../../common/enum/app_error_type.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/entities/auto_login_entity.dart';
import '../../domain/repositories/app_settings_repository.dart';
import '../data_source/app_settings_data_source.dart';

class AppSettingsRepositoryImpl extends AppSettingsRepository {
  final AppSettingsDataSource appSettingsDataSource;

  AppSettingsRepositoryImpl({
    required this.appSettingsDataSource,
  });

  @override
  Future<Either<AppError, String>> getAutoLoginStatus() async {
    try {
      final autoLoginEntity = await appSettingsDataSource.getAutoLogin();
      return Right(autoLoginEntity.userToken);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  @override
  Future<Either<AppError, void>> saveLoginStatus(
      AutoLoginEntity autoLoginEntity) async {
    try {
      final saveAutoLogin =
          await appSettingsDataSource.saveLoginStatus(autoLoginEntity);
      return Right(saveAutoLogin);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  @override
  Future<Either<AppError, void>> deleteAutoLogin() async {
    try {
      final deleteAutoLogin = await appSettingsDataSource.deleteAutoLogin();
      return Right(deleteAutoLogin);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  /// deleteCurrentUserData
  @override
  Future<Either<AppError, void>> deleteCurrentUserData() async {
    try {
      final deleteCurrentUser = await appSettingsDataSource.deleteCurrentUser();
      return Right(deleteCurrentUser);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  /// getCurrentUserData
  @override
  Future<Either<AppError, AuthorizedUserEntity>> getCurrentUserData() async {
    try {
      final currentUserData = await appSettingsDataSource.getCurrentUser();
      return Right(currentUserData);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  /// saveCurrentUserData
  @override
  Future<Either<AppError, void>> saveCurrentUserData(
      AuthorizedUserEntity userEntity) async {
    try {
      final saveCurrentUser =
          await appSettingsDataSource.saveCurrentUser(userEntity);
      return Right(saveCurrentUser);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  //=======================>  Notifications Settings   <======================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\

  /// getNotificationsListener
  @override
  Future<Either<AppError, Map<String, bool>>> getNotificationsListener() async {
    final value = await appSettingsDataSource.getNotificationsListener();
    log("value >> $value");
    return Right(value);
    // try {
    //   final value = await appSettingsDataSource.getNotificationsListener();
    //   log("value >> $value");
    //   final json =
    //       value.isEmpty ? ({} as Map<String, bool>) : jsonDecode(value);
    //   log("Json >> $json");
    //   return Right(json as Map<String, bool>);
    // } catch (e) {
    //   log("AppSettingsRepoImpl >> getNotificationsListener >> error: $e");
    //   return const Left(AppError(AppErrorType.sharedPreferences));
    // }
  }

  /// updateNotificationsListener
  @override
  Future<Either<AppError, void>> updateNotificationsListener(
      Map<String, bool> value) async {
    try {
      final str = jsonEncode(value);
      final updateValue =
          await appSettingsDataSource.updateNotificationsListener(str);
      return Right(updateValue);
    } on Exception catch (e) {
      log("AppSettingsRepoImpl >> updateNotificationsListener >> error: $e");
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }
}
