import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/no_params.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';

import '../../../entities/app_error.dart';
import '../../../repositories/app_settings_repository.dart';
import '../../use_case.dart';

class GetUserDataCase extends UseCase<AuthorizedUserEntity, NoParams> {
  final AppSettingsRepository appSettingsRepository;

  GetUserDataCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, AuthorizedUserEntity>> call(NoParams params) async =>
      await appSettingsRepository.getCurrentUserData();
}
