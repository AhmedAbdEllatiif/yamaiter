import 'package:dartz/dartz.dart';


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



  /*/// save CurrentUserData
  Future<Either<AppError, void>> saveCurrentUserData(
      UserEntity userEntity);

  /// save CurrentUserData
  Future<Either<AppError, void>> deleteCurrentUserData();

  /// return CurrentUserData
  Future<Either<AppError, UserEntity>> getCurrentUserData();*/
}
