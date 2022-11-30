import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/params/client/create_task_params.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../entities/app_error.dart';
import '../../../repositories/remote_repository.dart';

class CreateTaskClientCase
    extends UseCase<SuccessModel, CreateTaskParamsClient> {
  final RemoteRepository remoteRepository;

  CreateTaskClientCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          CreateTaskParamsClient params) async =>
      await remoteRepository.createTaskClient(params);
}
