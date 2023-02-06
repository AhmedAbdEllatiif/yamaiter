import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/update_profile/update_client_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class UpdateClientProfileCase
    extends UseCase<AuthorizedUserEntity, UpdateClientParams> {
  final RemoteRepository remoteRepository;

  UpdateClientProfileCase({required this.remoteRepository});

  @override
  Future<Either<AppError, AuthorizedUserEntity>> call(
          UpdateClientParams params) async =>
      await remoteRepository.updateClientProfile(params);
}
