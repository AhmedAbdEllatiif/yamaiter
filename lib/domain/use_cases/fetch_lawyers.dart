import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../data/params/client/get_lawyers_params.dart';

class FetchLawyersCase
    extends UseCase<List<LawyerEntity>, GetLawyersParams> {
  final RemoteRepository remoteRepository;

  FetchLawyersCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<LawyerEntity>>> call(
          GetLawyersParams params) async =>
      await remoteRepository.fetchLawyers(params);
}
