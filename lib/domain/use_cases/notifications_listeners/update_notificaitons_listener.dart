import 'package:dartz/dartz.dart';

import '../../entities/app_error.dart';
import '../../repositories/app_settings_repository.dart';
import '../use_case.dart';

class UpdateNotificationsListenersCase extends UseCase<void, Map<String, bool>> {
  final AppSettingsRepository appSettingsRepository;

  UpdateNotificationsListenersCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, void>> call(Map<String, bool> params) async =>
      await appSettingsRepository.updateNotificationsListener(params);
}
