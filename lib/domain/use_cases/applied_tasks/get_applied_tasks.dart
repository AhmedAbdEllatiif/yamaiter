import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/get_applied_tasks_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetAppliedTasksCase
    extends UseCase<List<TaskEntity>, GetAppliedTasksParams> {
  final RemoteRepository remoteRepository;

  GetAppliedTasksCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<TaskEntity>>> call(
          GetAppliedTasksParams params) async =>
      await remoteRepository.getAppliedTasks(params);
}
