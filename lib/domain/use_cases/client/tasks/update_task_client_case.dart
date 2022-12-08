import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/client/update_task_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../../data/models/success_model.dart';

class UpdateTaskClientCase
    extends UseCase<SuccessModel, UpdateTaskClientParams> {
  final RemoteRepository remoteRepository;

  UpdateTaskClientCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          UpdateTaskClientParams params) async =>
      await remoteRepository.updateTaskClient(params);
}
