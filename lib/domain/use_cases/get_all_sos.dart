import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../data/params/all_sos_params.dart';

class GetAllSosListCase extends UseCase<List<SosEntity>, GetAllSosParams> {
  final RemoteRepository remoteRepository;

  GetAllSosListCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<SosEntity>>> call(
          GetAllSosParams params) async =>
      await remoteRepository.getAllSosList(params);
}
