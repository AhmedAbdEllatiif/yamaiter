import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/apply_for_task.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/models/success_model.dart';

class ApplyForTaskCase extends UseCase<SuccessModel, ApplyForTaskParams> {
  final RemoteRepository remoteRepository;

  ApplyForTaskCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          ApplyForTaskParams params) async =>
      await remoteRepository.applyForTask(params);
}
