import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/delete_task_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/models/success_model.dart';

class DeleteTaskCase extends UseCase<SuccessModel, DeleteTaskParams> {
  final RemoteRepository remoteRepository;

  DeleteTaskCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(DeleteTaskParams params) async =>
      await remoteRepository.deleteTask(params);
}
