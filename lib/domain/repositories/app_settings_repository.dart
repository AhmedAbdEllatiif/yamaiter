import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';

import '../entities/app_error.dart';
import '../entities/auto_login_entity.dart';

abstract class AppSettingsRepository {
  /// save AutoLoginStatus
  Future<Either<AppError, void>> saveLoginStatus(
      AutoLoginEntity autoLoginEntity);

  /// save AutoLoginStatus
  Future<Either<AppError, void>> deleteAutoLogin();

  /// return AutoLoginStatus
  Future<Either<AppError, String>> getAutoLoginStatus();

  /// save CurrentUserData
  Future<Either<AppError, void>> saveCurrentUserData(
      AuthorizedUserEntity userEntity);

  /// save CurrentUserData
  Future<Either<AppError, void>> deleteCurrentUserData();

  /// return CurrentUserData
  Future<Either<AppError, AuthorizedUserEntity>> getCurrentUserData();

  /// updateNotificationsListener
  Future<Either<AppError, void>> updateNotificationsListener(
      Map<String, bool> value);

  /// getNotificationsListener
  Future<Either<AppError, Map<String, bool>>> getNotificationsListener();

  //===========================>  First launch  <=============================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\

  /// changeFirstLaunch
  Future<Either<AppError, void>> changeFirstLaunch();

  /// getFirstLaunchStatus
  Future<Either<AppError, bool>> getFirstLaunchStatus();
}
