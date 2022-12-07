import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class TopRatedLawyersCase extends UseCase<List<LawyerEntity>, String> {
  final RemoteRepository remoteRepository;

  TopRatedLawyersCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<LawyerEntity>>> call(String params) async =>
      await remoteRepository.topRatedLawyers(params);
}
