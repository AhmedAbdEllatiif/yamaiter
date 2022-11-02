import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/get_my_tasks_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';


class GetMyTasksCase extends UseCase<List<TaskEntity>, GetMyTasksParams> {
  final RemoteRepository remoteRepository;

  GetMyTasksCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<TaskEntity>>> call(GetMyTasksParams params) async =>
      await remoteRepository.getMyTasks(params);
}
