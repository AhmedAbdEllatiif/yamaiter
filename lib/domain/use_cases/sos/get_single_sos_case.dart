import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/params/get_single_sos_params.dart';

class GetSingleSosCase extends UseCase<SosEntity, GetSingleSosParams> {
  final RemoteRepository remoteRepository;

  GetSingleSosCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SosEntity>> call(GetSingleSosParams params) async =>
      await remoteRepository.getSingleSos(params);
}
