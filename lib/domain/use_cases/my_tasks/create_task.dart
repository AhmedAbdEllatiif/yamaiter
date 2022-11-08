import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/create_task_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/models/success_model.dart';

class CreateTaskCase extends UseCase<SuccessModel, CreateTaskParams> {
  final RemoteRepository remoteRepository;

  CreateTaskCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(CreateTaskParams params) async =>
      await remoteRepository.createTask(params);
}
