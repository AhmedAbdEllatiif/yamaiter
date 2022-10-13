import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/params/all_sos_params.dart';

class GetMySosListCase extends UseCase<List<SosEntity>, GetSosParams> {
  final RemoteRepository remoteRepository;

  GetMySosListCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<SosEntity>>> call(GetSosParams params) async =>
      await remoteRepository.getMySosList(params);
}
