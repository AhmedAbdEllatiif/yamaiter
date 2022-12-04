import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/client/end_task_params_client.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../../data/models/success_model.dart';

class EndTaskClientCase extends UseCase<SuccessModel, EndTaskParamsClient> {
  final RemoteRepository remoteRepository;

  EndTaskClientCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          EndTaskParamsClient params) async =>
      await remoteRepository.endTaskClient(params);
}
