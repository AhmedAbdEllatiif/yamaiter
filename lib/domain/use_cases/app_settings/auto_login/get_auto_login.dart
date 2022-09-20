import 'package:dartz/dartz.dart';

import '../../../entities/app_error.dart';
import '../../../entities/params/no_params.dart';
import '../../../repositories/app_settings_repository.dart';
import '../../use_case.dart';

class GetAutoLoginCase extends UseCase<String, NoParams> {
  final AppSettingsRepository appSettingsRepository;

  GetAutoLoginCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, String>> call(NoParams params) async =>
      appSettingsRepository.getAutoLoginStatus();
}
