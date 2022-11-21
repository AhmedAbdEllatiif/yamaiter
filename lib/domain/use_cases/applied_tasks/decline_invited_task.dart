import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/params/decline_task_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

import '../../../data/models/success_model.dart';

class DeclineInvitedTaskCase extends UseCase<SuccessModel, DeclineTaskParams> {
  final RemoteRepository remoteRepository;

  DeclineInvitedTaskCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(DeclineTaskParams params) async =>
      await remoteRepository.declineTask(params);
}
