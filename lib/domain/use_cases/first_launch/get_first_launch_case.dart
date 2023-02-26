import 'package:dartz/dartz.dart';

import '../../../data/params/no_params.dart';
import '../../entities/app_error.dart';
import '../../repositories/app_settings_repository.dart';
import '../use_case.dart';

class GetFirstLaunchCase extends UseCase<bool, NoParams> {
  final AppSettingsRepository appSettingsRepository;

  GetFirstLaunchCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, bool>> call(NoParams params) async =>
      await appSettingsRepository.getFirstLaunchStatus();
}
