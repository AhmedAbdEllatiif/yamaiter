import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/params/get_all_task_params.dart';

class GetAllTasksCase extends UseCase<List<TaskEntity>, GetAllTasksParams> {
  final RemoteRepository remoteRepository;

  GetAllTasksCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<TaskEntity>>> call(
          GetAllTasksParams params) async =>
      await remoteRepository.getAllTasks(params);
}
