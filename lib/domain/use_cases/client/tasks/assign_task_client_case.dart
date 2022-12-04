import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../../data/models/success_model.dart';
import '../../../../data/params/client/assign_task_params_client.dart';

class AssignTaskClientCase extends UseCase<SuccessModel, AssignTaskParamsClient> {
  final RemoteRepository remoteRepository;

  AssignTaskClientCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          AssignTaskParamsClient params) async =>
      await remoteRepository.assignTaskClient(params);
}
