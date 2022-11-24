import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/params/invite_to_task_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';
import 'package:yamaiter/domain/use_cases/use_case.dart';

class InviteToTaskCase extends UseCase<SuccessModel, InviteToTaskParams> {
  final RemoteRepository remoteRepository;

  InviteToTaskCase({required this.remoteRepository});

  @override
  Future<Either<AppError, SuccessModel>> call(
          InviteToTaskParams params) async =>
      await remoteRepository.inviteToTask(params);
}
