import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/search_for_lawyer_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class SearchForLawyerCase
    extends UseCase<List<LawyerEntity>, SearchForLawyerParams> {
  final RemoteRepository remoteRepository;

  SearchForLawyerCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<LawyerEntity>>> call(
          SearchForLawyerParams params) async =>
      await remoteRepository.searchForLawyers(params);
}
