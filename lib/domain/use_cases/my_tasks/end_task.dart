import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/end_task_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/models/success_model.dart';

class EndTaskCase extends UseCase<SuccessModel, EndTaskParams> {
  final RemoteRepository remoteRepository;

  EndTaskCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(EndTaskParams params) async =>
      await remoteRepository.endTask(params);
}
