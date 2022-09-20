import 'package:dartz/dartz.dart';


import '../../common/enum/app_error_type.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/entities/auto_login_entity.dart';
import '../../domain/repositories/app_settings_repository.dart';
import '../data_source/app_settings_local_data_source.dart';

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
      final deleteAutoLogin =
          await appSettingsDataSource.deleteAutoLogin();
      return Right(deleteAutoLogin);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

 /* /// deleteCurrentUserData
  @override
  Future<Either<AppError, void>> deleteCurrentUserData() async {
    try {
      final deleteCurrentUser =
          await appSettingsLocalDataSource.deleteCurrentUser();
      return Right(deleteCurrentUser);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  /// getCurrentUserData
  @override
  Future<Either<AppError, UserEntity>> getCurrentUserData() async {
    try {
      final currentUserData = await appSettingsLocalDataSource.getCurrentUser();
      return Right(currentUserData);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  /// saveCurrentUserData
  @override
  Future<Either<AppError, void>> saveCurrentUserData(
      UserEntity userEntity) async {
    try {
      final saveCurrentUser =
          await appSettingsLocalDataSource.saveCurrentUser(userEntity);
      return Right(saveCurrentUser);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }*/
}
