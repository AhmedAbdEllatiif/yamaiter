import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/register_lawyer_request_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/register_response_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class RegisterLawyerCase
    extends UseCase<RegisterResponseEntity, RegisterLawyerRequestParams> {
  final RemoteRepository remoteRepository;

  RegisterLawyerCase({required this.remoteRepository});

  @override
  Future<Either<AppError, RegisterResponseEntity>> call(
          RegisterLawyerRequestParams params) async =>
      await remoteRepository.registerLawyer(params);
}
