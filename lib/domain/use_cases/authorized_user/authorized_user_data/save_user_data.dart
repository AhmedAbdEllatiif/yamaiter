import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';

import '../../../entities/app_error.dart';
import '../../../repositories/app_settings_repository.dart';
import '../../use_case.dart';

class SaveUserDataCase extends UseCase<void, AuthorizedUserEntity> {
  final AppSettingsRepository appSettingsRepository;

  SaveUserDataCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, void>> call(AuthorizedUserEntity params) async =>
      await appSettingsRepository.saveCurrentUserData(params);
}
