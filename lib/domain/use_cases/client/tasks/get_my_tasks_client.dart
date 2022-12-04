import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/client/get_my_task_params_client.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../entities/app_error.dart';
import '../../../repositories/remote_repository.dart';

class GetMyTasksCaseClient
    extends UseCase<List<TaskEntity>, GetMyTasksClientParams> {
  final RemoteRepository remoteRepository;

  GetMyTasksCaseClient({required this.remoteRepository});

  @override
  Future<Either<AppError, List<TaskEntity>>> call(
          GetMyTasksClientParams params) async =>
      await remoteRepository.getMyTasksClient(params);
}
