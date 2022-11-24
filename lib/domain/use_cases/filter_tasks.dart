import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/filter_task_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class FilterTasksCase extends UseCase<List<TaskEntity>, FilterTasksParams> {
  final RemoteRepository remoteRepository;

  FilterTasksCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<TaskEntity>>> call(
          FilterTasksParams params) async =>
      await remoteRepository.filterTasks(params);
}
