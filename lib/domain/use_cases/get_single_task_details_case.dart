import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/my_single_task_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetSingleTaskDetailsCase
    extends UseCase<TaskEntity, GetSingleTaskParams> {
  final RemoteRepository remoteRepository;

  GetSingleTaskDetailsCase({required this.remoteRepository});

  @override
  Future<Either<AppError, TaskEntity>> call(GetSingleTaskParams params) async =>
      await remoteRepository.getSingleTaskDetails(params);
}
