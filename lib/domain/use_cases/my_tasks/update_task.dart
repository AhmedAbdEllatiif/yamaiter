import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/models/success_model.dart';
import '../../../data/params/update_task_params.dart';

class UpdateTaskCase extends UseCase<SuccessModel, UpdateTaskParams> {
  final RemoteRepository remoteRepository;

  UpdateTaskCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(UpdateTaskParams params) async =>
      await remoteRepository.updateTask(params);
}
