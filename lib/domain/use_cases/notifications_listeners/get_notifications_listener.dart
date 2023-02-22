import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/no_params.dart';

import '../../entities/app_error.dart';
import '../../repositories/app_settings_repository.dart';
import '../use_case.dart';

class GetNotificationsListenersCase
    extends UseCase<Map<String, bool>, NoParams> {
  final AppSettingsRepository appSettingsRepository;

  GetNotificationsListenersCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, Map<String, bool>>> call(NoParams params) async =>
      await appSettingsRepository.getNotificationsListener();
}
