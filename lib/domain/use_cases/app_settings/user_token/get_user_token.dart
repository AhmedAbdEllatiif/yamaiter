import 'package:dartz/dartz.dart';

import '../../../entities/app_error.dart';
import '../../../entities/params/no_params.dart';
import '../../../repositories/app_settings_repository.dart';
import '../../use_case.dart';

class GetUserTokenCase extends UseCase<String, NoParams> {
  final AppSettingsRepository appSettingsRepository;

  GetUserTokenCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, String>> call(NoParams params) async =>
      appSettingsRepository.getAutoLoginStatus();
}
