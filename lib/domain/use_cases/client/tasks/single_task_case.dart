import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/client/get_single_task_params_client.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetSingleTaskClientCase
    extends UseCase<TaskEntity, GetSingleTaskParamsClient> {
  final RemoteRepository remoteRepository;

  GetSingleTaskClientCase({required this.remoteRepository});

  @override
  Future<Either<AppError, TaskEntity>> call(
          GetSingleTaskParamsClient params) async =>
      await remoteRepository.getSingleTaskClient(params);
}
