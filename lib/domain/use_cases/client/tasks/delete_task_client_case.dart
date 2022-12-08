import 'package:dartz/dartz.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../../data/models/success_model.dart';
import '../../../../data/params/client/delete_task_params.dart';

class DeleteTaskClientCase
    extends UseCase<SuccessModel, DeleteTaskClientParams> {
  final RemoteRepository remoteRepository;

  DeleteTaskClientCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          DeleteTaskClientParams params) async =>
      await remoteRepository.deleteTaskClient(params);
}
