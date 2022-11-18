import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/get_invited_task_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class GetInvitedTasksCase
    extends UseCase<List<TaskEntity>, GetInvitedTasksParams> {
  final RemoteRepository remoteRepository;

  GetInvitedTasksCase({required this.remoteRepository});

  @override
  Future<Either<AppError, List<TaskEntity>>> call(
          GetInvitedTasksParams params) async =>
      await remoteRepository.getInvitedTasks(params);
}
