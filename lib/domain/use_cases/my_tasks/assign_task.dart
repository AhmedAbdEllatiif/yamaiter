import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/assign_task_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/models/success_model.dart';

class AssignTaskCase extends UseCase<SuccessModel, AssignTaskParams> {
  final RemoteRepository remoteRepository;

  AssignTaskCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(AssignTaskParams params) async =>
      await remoteRepository.assignTask(params);
}
