import 'package:dartz/dartz.dart';

import '../../../entities/app_error.dart';
import '../../../entities/params/no_params.dart';
import '../../../repositories/app_settings_repository.dart';
import '../../use_case.dart';



class DeleteAutoLoginCase extends UseCase<void, NoParams> {
  final AppSettingsRepository appSettingsRepository;

  DeleteAutoLoginCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, void>> call(NoParams params) async =>
      appSettingsRepository.deleteAutoLogin();
}
