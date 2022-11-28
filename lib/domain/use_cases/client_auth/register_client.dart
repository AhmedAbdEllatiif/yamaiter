import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/register_client_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/register_response_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class RegisterClientCase
    extends UseCase<RegisterResponseEntity, RegisterClientParams> {
  final RemoteRepository remoteRepository;

  RegisterClientCase({required this.remoteRepository});

  @override
  Future<Either<AppError, RegisterResponseEntity>> call(
          RegisterClientParams params) async =>
      await remoteRepository.registerClient(params);
}
