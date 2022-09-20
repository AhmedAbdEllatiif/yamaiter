import 'package:dartz/dartz.dart';

import '../../../entities/app_error.dart';
import '../../../entities/auto_login_entity.dart';
import '../../../repositories/app_settings_repository.dart';
import '../../use_case.dart';


class SaveAutoLoginCase extends UseCase<void, AutoLoginEntity> {
  final AppSettingsRepository appSettingsRepository;

  SaveAutoLoginCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, void>> call(AutoLoginEntity params) async =>
      appSettingsRepository.saveLoginStatus(params);
}
