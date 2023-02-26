import 'package:dartz/dartz.dart';

import '../../../data/params/no_params.dart';
import '../../entities/app_error.dart';
import '../../repositories/app_settings_repository.dart';
import '../use_case.dart';

class ChangeFirstLaunchCase extends UseCase<void, NoParams> {
  final AppSettingsRepository appSettingsRepository;

  ChangeFirstLaunchCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, void>> call(NoParams params) async =>
      await appSettingsRepository.changeFirstLaunch();
}
