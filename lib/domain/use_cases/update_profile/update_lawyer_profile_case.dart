import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/update_profile/update_lawyer_profile.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class UpdateLawyerProfileCase
    extends UseCase<AuthorizedUserEntity, UpdateLawyerParams> {
  final RemoteRepository remoteRepository;

  UpdateLawyerProfileCase({required this.remoteRepository});

  @override
  Future<Either<AppError, AuthorizedUserEntity>> call(
          UpdateLawyerParams params) async =>
      await remoteRepository.updateLawyerProfile(params);
}
